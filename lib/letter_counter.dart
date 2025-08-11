import 'dart:io';

import 'package:televerse/televerse.dart';

void main(List<String> args) {
  // Create a new bot instance
  Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

  // The command method can be used to register a command handler
  // You'll have to pass two arguments: the command name and the handler

  // The handler is a function that takes a [Context] as an argument
  bot.command("start", (ctx) async {
    // The message context contains all the information about the incoming message
    // and bunch of useful methods to reply to it.

    final String? name = ctx.from?.firstName;

    // The reply method can be used to send a message to the chat where the message
    await ctx.reply("Hello $name!");
  });

  /// The [onText] method can be used to register a handler for a incoming text messages
  ///
  /// The handler is a function that takes a [Context] as an argument.
  /// The context type depends on the event type. This is why we have to cast it.
  bot.onText((ctx) async {
    // We can get the message text and count the letters
    final int letterCount = ctx.text!.length;

    // We can reply to the message
    await ctx.reply("Your message has $letterCount letters.");
  });

  // Start the bot
  bot.start();
}
