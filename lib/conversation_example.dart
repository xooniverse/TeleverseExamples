import 'dart:io';
import 'package:televerse/plugins/conversation.dart';
import 'package:televerse/televerse.dart';

// Create the bot instance
Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

void main() async {
  bot.plugin(ConversationPlugin());

  bot.use(createConversation('basic-info', welcomeHandler));

  /// For the sake of simplicity, we will only setup the bot to listen to
  /// the start command and just ask the user for their name.
  ///
  /// So let's start the bot and setup a handler for the start command.
  bot.command('start', (ctx) => ctx.enterConversation('basic-info'));

  // Start the bot
  await bot.start();
}

// We define the welcomeHandler function to handle the start command.
Future<void> welcomeHandler(Conversation conversation, Context ctx) async {
  // Reply a greeting
  await ctx.reply("Welcome to Televerse Conversation!");
  await ctx.reply("What is your name?");

  // ✨ The magic happens here ✨
  var nameCtx = await conversation.filter(Filters().text);

  // Reply with the user's name
  await ctx.reply("Hello, ${nameCtx.text}!");
}
