import { ChatInputCommandInteraction, SlashCommandBuilder } from "discord.js"
import getRandomQuote from "../../utils/getRandomQuote.js";
import { QuoteType } from "../../types/types.js";

const hello = {
  data: new SlashCommandBuilder()
    .setName("hello")
    .setDescription("Say hello to ami."),
  execute: async (interaction: ChatInputCommandInteraction) => {
    await interaction.reply(getRandomQuote(QuoteType.HELLO_RESPONSE));
  },
};

export default hello;
