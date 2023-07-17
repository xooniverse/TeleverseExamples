import 'dart:io';

import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

extension Command on Message {
  String get command => text!.split(" ")[0];
}

void main(List<String> args) {
  // Create a new bot instance
  Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

  // Specify the admin ID
  ChatID admin = ChatID(int.parse(Platform.environment["ADMIN_ID"]!));

  // Bot.command method can be used to register a command handler
  bot.command('ban', (ctx) async {
    // Check if the user is the admin
    if (ctx.message.from!.id != admin.id) {
      await ctx.reply("You're not allowed to use this command!");
      return;
    }

    // Check if the user replied to a message
    if (ctx.message.replyToMessage == null) {
      await ctx.reply("Reply to a message to ban the user!");
      return;
    }

    try {
      // Simply call the ctx.banAuthor method to ban the user who sent the replied message.
      // `ctx.banAuthor` is an context aware alias for the `RawAPI.banChatMember` method.
      // It will automatically ban the user who sent the replied message.
      bool success = await ctx.banAuthor();

      // Confirm the ban
      if (success) {
        await ctx.reply("User banned!");
      } else {
        await ctx.reply("Failed to ban the user!");
      }
    } catch (e) {
      await ctx.reply("I just ran into some problem, Houston!");
    }
  });
}
