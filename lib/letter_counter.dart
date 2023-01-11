import 'dart:io';

import 'package:televerse/televerse.dart';

Bot letterCounterBot = Bot(Platform.environment["BOT_TOKEN"]!);

Future<void> startLetterCounterBot() async {
  letterCounterBot.command("start", (ctx) {
    final String name = ctx.message.from!.firstName;
    ctx.reply("Hello $name!");
  });

  letterCounterBot.on(TeleverseEvent.text, (ctx) {
    ctx as MessageContext;
    final int letterCount = ctx.message.text!.length;
    ctx.reply("Your message has $letterCount letters.");
  });

  letterCounterBot.start();
}
