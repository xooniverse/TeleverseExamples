import 'dart:io';

import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

/// This bot allows you to downloads the audio files you send to it
void main() async {
  /// Creates the bot instance
  final Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

  /// Adds a listener for audio files
  bot.filter((ctx) {
    return ctx.msg?.audio != null;
  }, (ctx) async {
    final aud = ctx.message?.audio;
    final file = await ctx.api.getFile(aud!.fileId);
    // you can now get file bytes using
    // await file.getBytes();
    // or download it like:
    await file.download();

    await ctx.reply("Done downloading file ${file.fileName}");
  });

  /// Sets up the /start command listener
  bot.command('start', (ctx) async {
    await ctx.reply("Send me an audio file");
  });

  /// Adds a listener for every command (also excuted for /start)
  bot.entity(MessageEntityType.botCommand, (ctx) async {
    await ctx.reply("Got a command: ${ctx.message?.text}");
  });

  /// Starts the bot
  await bot.start();
}
