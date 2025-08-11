import 'dart:io';

import 'package:televerse/televerse.dart';

void main(List<String> args) async {
  final bot = Bot(Platform.environment["BOT_TOKEN"]!);

  bot.command('start', (ctx) async {
    await ctx.reply('🚀 Hello! This is a webhook bot!');
  });

  bot.onText((ctx) async {
    await ctx.reply('You said: "${ctx.text}"');
  });

  // That's it! One line to start a webhook bot
  await bot.startWebhookDev(
    'https://your-domain.com',
    port: 8080,
  );
}
