import 'dart:io';
import 'package:televerse/televerse.dart';

// Create the bot instance
Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create the conversation instance with the bot instance
Conversation conversation = Conversation(bot);

void main() async {
  /// For the sake of simplicity, we will only setup the bot to listen to
  /// the start command and just ask the user for their name.
  ///
  /// So let's start the bot and setup a handler for the start command.
  bot.command('start', welcomeHandler);

  // Start the bot
  await bot.start();
}

// We define the welcomeHandler function to handle the start command.
Future<void> welcomeHandler(Context ctx) async {
  // Reply a greeting
  await ctx.reply("Welcome to Televerse Conversation!");
  await ctx.reply("What is your name?");

  // ✨ The magic happens here ✨
  // We can wait for the user's reply using the `waitForTextMessage` method.
  var response = await conversation.waitForTextMessage(chatId: ctx.id);

  if (response is! ConversationSuccess<Context>) {
    await ctx.reply("Something went wrong.");

    response as ConversationFailure<Context>;
    print(response.state);
    print(response.message);

    return;
  }

  // Reply with the user's name
  await ctx.reply("Hello, ${response.data.message?.text}!");
}
