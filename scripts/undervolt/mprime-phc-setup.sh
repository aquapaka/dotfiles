#!/bin/bash

# Find lowest vids for PHC so that mprime doesn't find errors.
# Shouldn't crash the computer, but might.

#####################################
# Parameters.

# short_test_length should be between 15 and 60 s.
# Use a longer length to avoid crashing during the test.
short_test_length=15

# long_test_length should be between 60 and 7200 s or more.
# Bigger values are safer, but increase the test's length.
long_test_length=60

# safety_vid_delta should be between 1 and 4. Bigger values are safer.
# Suggestions:
# - use 4 if long_test_length < 60
# - use 3 if long_test_length >= 60 and < 240
# - use 2 if long_test_length >= 240
# - use 1 only if long_test_length >= 3600
safety_vid_delta=2

debug=0

amd_max_vid=124

# Tolerance for inaccurate frequencies during the test (in percent)
# Added because of https://bbs.archlinux.org/viewtopic.php?pid=1301126#p1301126
# NOTE: actually it seems that the problem is different: some CPUs have a bogus 1st
#       frequency that is 1 MHz higher than the real top frequency (the 2nd one).
wrong_freq_tolerance=100

#####################################

# Check that settings are sane
if (( short_test_length < 15 )); then
	echo "Forcing short_test_length to 15 seconds."
	short_test_length=15
fi
if (( long_test_length < 30 )); then
	echo "Forcing long_test_length to 30 seconds."
	long_test_length=30
fi
if (( safety_vid_delta < 1 )); then
	echo "Forcing safety vid delta to 1."
	safety_vid_delta=1
fi

# Need root privileges to change the vids
if [[ `whoami` != root ]]; then
	echo "Run me as root."
	exit 1
fi

# Check that mprime is available
which mprime &>/dev/null
if (( $? != 0 )); then
	echo "mprime is not in the path."
	if [[ ! -e ./mprime ]]; then
		echo "No mprime in the current directory either... Aborting."
		exit 1
	fi
	echo "Using mprime from the current directory."
	mp="./mprime -t"
else
	mp="mprime -t"
fi

# Check that PHC is active
cpuf=/sys/devices/system/cpu/cpu0/cpufreq
if [[ ! -e $cpuf/phc_default_vids ]]; then
	echo "The PHC module doesn't seem to be loaded."
	exit 1
fi

# Check if AMD processor, then need to reverse the search direction
if lsmod | grep phc_k8 >/dev/null ; then
	vid_delta=1
	vid_limit=$amd_max_vid
else
	vid_delta=-1
	vid_limit=0
fi

# Warn user about end of the world
echo ""
echo "Warning: this might crash your computer or applications."
echo "Please save all your work and don't do anything while the test is running."
echo "You can stop the test at any time with CTRL-C."
echo "Press RETURN to go on or CTRL-C to cancel."
read

function set_sys_val
{
	#echo Writing $2 to $1
	for i in /sys/devices/system/cpu/cpu*/cpufreq/$1; do
		echo "$2" > $i
	done
}

function debug_info
{
	for i in /sys/devices/system/cpu/cpu*/cpufreq/{scaling_governor,cpuinfo_cur_freq,scaling_cur_freq,phc_vids}; do
		echo -n $i | sed 's/\/sys\/devices\/system\/cpu\///'
		echo " = $(cat $i)"
	done
}

# Store stuff to be able to cleanup later
backup_governor=$(cat $cpuf/scaling_governor)
backup_phc_vids=$(cat $cpuf/phc_vids)

#if [[ $backup_governor != userspace ]]; then
	echo "Switching to the userspace governor. $backup_governor will be restored later."
	modprobe cpufreq_userspace
	set_sys_val scaling_governor userspace
#fi

# File to save the state in order to continue after a crash
crash_state="/var/tmp/$(basename $0).state"

# Log file for mprime
mp_log=/tmp/$(basename $0).mp

# process ID of mprime
mp_pid=-1

function launch_mprime
{
	$mp &>$mp_log &
	mp_pid=$!
}

function kill_mprime
{
	(( mp_pid <= 1 )) && return
	kill -9 $mp_pid
	wait $mp_pid &>/dev/null # needed to suppress the "killed" message by bash
	mp_pid=-1
}

function cleanup
{
	echo ""
	echo "Restoring state..."

	kill_mprime

	# Restore vids
	set_sys_val phc_vids "$backup_phc_vids"

	# Restore governor
	set_sys_val scaling_governor "$backup_governor"

	# Delete log
	[[ -e $mp_log ]] && rm $mp_log

	# Delete state file
	[[ -e "$crash_state" ]] && rm "$crash_state"
}

# Restore original state whenever the script exits
trap cleanup EXIT

# List all vids and frequencies
freqs=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
default_vids=$(cat /sys/devices/system/cpu/cpu0/cpufreq/phc_default_vids)

nb_freqs=0
for f in $freqs; do
	#echo $nb_freqs - $f
	freq[nb_freqs]=$f
	((nb_freqs++))
done

nb_vids=0
for v in $default_vids; do
	#echo $nb_vids - $v
	vid[nb_vids]=$v
	((nb_vids++))
done

if [[ $nb_freqs != $nb_vids ]]; then
	echo "Error: number of vids and number of frequencies differ!"
	exit 1
fi

# Check that writing to scaling_max_freq works (I had this problem)
#set_sys_val scaling_max_freq ${freq[1]}
#if [[ $backup_scaling_max_freq == $(cat $cpuf/scaling_max_freq) ]]; then
#	echo "Error: cannot write to scaling_max_freq!"
#	echo "Try updating your kernel, rebooting and/or reinstalling PHC."
#	exit 1
#fi

# Estimate length of test
estimate_min=$((short_test_length * (${vid[0]} - 2) + long_test_length))
estimate_max=$((short_test_length * (${vid[0]} - 2) + nb_freqs * long_test_length * 3 / 2))

function print_time
{
	# input: $1 = number of seconds
	# output: xx h yy min
	local seconds=$1
	local days=$((seconds/3600/24))
	local seconds=$((seconds-days*3600*24))
	local hours=$((seconds/3600))
	seconds=$((seconds-hours*3600))
	local minutes=$((seconds/60))
	local r
	((days>0)) && r="$days d "
	((hours>0 || days>0)) && r="$r$hours h "
	((days==0)) && r="$r$minutes min"
	echo -n $r
}

echo -n "Estimated time to completion: between "
print_time estimate_min
echo -n " and "
print_time estimate_max
echo ""


# For each available frequency, try to lower the vid as much as possible

# 1st pass: Lower the vid, test mprime for a small amount of time at each step.
#           If an error is detected, increment cur_vid and continue with pass 2.
#           If vid 0 is reached, continue with pass 2.
# 2nd pass: Test cur_vid for a long time.
#           If there is an error, increment cur_vid and loop.
#           Stop when there is no error or cur_vid >= max_vid-delta.
# Final step: best_vid=cur_vid+delta

# set_vid index vid
function set_vid
{
	# Generate phc_vids string
	local v=""
	local i
	for (( i=0; i<nb_freqs; i++ )); do
		if (( $i == $1 )); then
			v="$v$2"
		else
			v="$v${vid[i]}"
		fi
		(( i < nb_freqs-1 )) && v="$v "
	done
	set_sys_val phc_vids "$v"
}

# Save progress in order to be able to continue after a crash
function save_state
{
	# Restore default vids before writing to disk to avoid a possible crash
	set_sys_val phc_vids "$default_vids"

	# state file contains:
	# - current frequency between 0 and nb_freqs - 1
	# - current VID
	# - current list of best VIDS found
	echo $f >"$crash_state"
	echo $cur_vid >>"$crash_state"
	echo "$final_vids" >>"$crash_state"
	sync
	sleep 1
}

function read_state
{
	f=$(head -1 "$crash_state")
	cur_vid=$(sed -n 2p "$crash_state")
	final_vids="$(tail -1 "$crash_state")"
	#echo f=$f
	#echo cur_vid=$cur_vid
	#echo final_vids="-"$final_vids"-"
}

# Check if state file exists, which probably means the computer crashed
if [[ -e "$crash_state" ]]; then
	read_state
	echo
	echo "State file $crash_state detected."
	echo "Frequency: $f"
	echo "Current VID: $cur_vid"
	echo "Current best vids: $final_vids"
	echo "Press return to continue from this point after a crash, or CTRL-C to delete the state file."
	read

	# There was a crash at $cur_vid, so increase it and go directly to pass 2
	cur_vid=$((cur_vid-2*vid_delta))
	pass2=1
else
	cur_vid=${vid[0]}
	f=0
	pass2=0
fi

for (( ; f<nb_freqs; f++ )); do
	echo ""
	echo "Testing frequency $f (${freq[f]})..."
	echo "Default vid: ${vid[f]}"

	# Based on comments found on this page:
	# http://openmindedbrain.info/09/05/2010/undervolting-in-ubuntu-10-04-lucid-lts/
	# it appears that some processors have a bogus 1st frequency that will always go
	# down to VID 0 and is in fact unused.

	if (( f == 0 && ${freq[0]} == ${freq[1]} + 1000 )); then
		echo "Looks like the first frequency is bogus; ignoring it."
		final_vids="${vid[0]} "
		continue
	fi

	# Pass 1: lowering vid quickly until there is an error

	if (( cur_vid*vid_delta < ${vid[f]}*vid_delta && pass2 == 0 )); then
		#echo "forcing cur vid to max"
		cur_vid=${vid[f]}
	fi

	cur_vid=$((cur_vid+vid_delta))

	for (( ; cur_vid*vid_delta < vid_limit*vid_delta && pass2 == 0; cur_vid+=vid_delta )); do
		count=$short_test_length

		echo "Trying vid $cur_vid for $count seconds"
		save_state

		set_vid $f $cur_vid

		# It looks like changing the VID also resets the frequency, so set frequency here
		set_sys_val scaling_setspeed ${freq[f]}

		launch_mprime

		if ((debug)); then
			sleep 1
			debug_info
		fi

		for (( ; count>0; count-- )); do
			sleep 1
			echo -n "."
			grep FATAL $mp_log &>/dev/null
			if (( $? == 0 )); then
				kill_mprime
				echo ""
				echo "Hardware failure detected."
				((cur_vid-=vid_delta))
				break 2
			fi
			cur_freq=$(cat $cpuf/scaling_cur_freq)
			if (( (cur_freq < ${freq[f]} * (100 - wrong_freq_tolerance) / 100)
				|| (cur_freq > ${freq[f]} * (100 + wrong_freq_tolerance) / 100) )); then
				echo ""
				echo "ERROR: Wrong frequency! (${cur_freq} instead of ${freq[f]})"
				debug_info
				exit 1
			fi
		done

		echo ""

		kill_mprime
	done

	# Pass 2: stress testing for a longer time and going up in case of an error.

	for (( ; cur_vid*vid_delta <= vid_limit && cur_vid*vid_delta > (${vid[f]}+safety_vid_delta*vid_delta)*vid_delta; cur_vid-=vid_delta )); do
		count=$long_test_length
		echo "Trying vid $cur_vid for $count seconds"
		save_state

		set_vid $f $cur_vid
		set_sys_val scaling_setspeed ${freq[f]}

		launch_mprime

		if ((debug)); then
			debug_info
		fi

		for (( ; count>0; count-- )); do
			sleep 1
			echo -n "."
			grep FATAL $mp_log &>/dev/null
			if (( $? == 0 )); then
				echo ""
				echo "Hardware failure detected."
				break
			fi
		done

		kill_mprime

		if (( count == 0 )); then
			break
		fi
	done

	echo ""
	echo "Found working vid. Adding $safety_vid_delta for safety."
	(( cur_vid*vid_delta > vid_limit*vid_delta )) && cur_vid=$vid_limit
	if (( (cur_vid - safety_vid_delta*vid_delta)*vid_delta < ${vid[f]}*vid_delta )); then
		final_vids=${final_vids}${vid[f]}
	else
		final_vids=${final_vids}$((cur_vid-safety_vid_delta*vid_delta))
	fi
	(( f < nb_freqs-1 )) && final_vids="$final_vids "
	echo "Current results: $final_vids"

	pass2=0

done

echo ""
echo "All done."
echo "Default vids: $default_vids"
echo "Final vids:   $final_vids"
echo ""
if [[ -e /etc/default/phc-intel ]]; then
	# Newest version of the AUR phc-intel package
	echo "Edit /etc/default/phc-intel to add your final vids."
elif [[ -e /etc/phc-intel.conf ]]; then
	# Old version of the AUR phc-intel package
	echo "Edit /etc/phc-intel.conf to add your final vids."
elif [[ -e /etc/conf.d/phc-intel ]]; then
	# Old version of the AUR phc-intel package, or current dkms-phc-intel package.
	echo "Edit /etc/conf.d/phc-intel to add your final vids."
elif [[ -e /etc/default/phc-k8 ]]; then
	# Newest version of the AUR phc-k8 package
	echo "Edit /etc/default/phc-k8 to add your final vids."
else
	echo "If your system has a working rc.local (probably not the case with systemd), you can add the following 3 lines to /etc/rc.local, before the final \"exit 0\":"
	echo ""
	echo "for i in /sys/devices/system/cpu/cpu*/cpufreq/phc_vids; do"
	echo "  echo \"$final_vids\" > \$i"
	echo "done"
fi