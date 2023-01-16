import 'dart:io';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

void main(List<String> args) {
  Bot bot = Bot(Platform.environment['BOT_TOKEN']!);
  bot.command("start", (ctx) async {
    // Send a welcome message
    await ctx.reply("Hello, ${ctx.message.from!.firstName}!");

    // When you attach a listener to the start command, Televerse will automatically be
    // able to parse the start parameter and set it to the [ctx.startParameter] property.

    // So whenever the user is coming from a deep link such as https://t.me/your_bot?start=123
    // the [ctx.startParameter] will be set to "123" and you can start doing your magic. 🦄

    if (ctx.startParameter != null) {
      int refId = int.parse(ctx.startParameter!);

      // You obiviously don't want the user to be able to refer himself
      if (refId == ctx.message.from!.id) {
        await ctx.reply("Oh no! You can't refer yourself!");
        return;
      }

      ChatID chatId = ChatID(refId);

      // Get Referrer's profile
      Chat referrer = await chatId.chat;

      // Add points to the referrer on database 🎉
      // ...

      // Send a message to the referrer
      await bot.sendMessage(
        chatId,
        "Hello ${referrer.firstName}, you have a new referral! 🎉",
      );
    }
  });

  // Send a referral link to the user when he sends /invite
  bot.command("invite", (ctx) async {
    await ctx.reply("Invite your friends to this bot and get points! 🎉");

    // Next line is unnecessary if you already know the bot's username. You obviously know it :)
    final botInfo = await bot.getMe();

    await ctx.reply(
      "Here's your referral link. https://t.me/${botInfo.username}?start=${ctx.message.from!.id}",
    );
  });

  bot.start();
}
