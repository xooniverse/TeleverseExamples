import 'dart:io';
import 'package:televerse/televerse.dart';

void main(List<String> args) async {
  /// Get the token from the environment variables.
  final token = Platform.environment['BOT_TOKEN']!;

  /// Use the [Bot.local] constructor to create a bot instance.
  final bot = Bot.local(token, 'http://localhost:8081');

  /// Attach the /start command handler
  bot.command('start', (ctx) async {
    await ctx.reply('Hello, World!');
  });

  /// Start polling for updates
  await bot.start();
}
