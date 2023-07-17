import 'dart:io';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

void main(List<String> args) {
  Bot bot = Bot(Platform.environment['BOT_TOKEN']!);

  // We can use the start method to listen to the start command also to start listening for updates
  bot.start((ctx) async {
    // Send a welcome message
    await ctx.reply("Hello, ${ctx.message.from!.firstName}!");

    // When you attach a listener to the start command, Televerse will automatically be
    // able to parse the start parameter and set it to the [ctx.args] property.

    // So whenever the user is coming from a deep link such as https://t.me/your_bot?start=123
    // the [ctx.args] will be set to "123" and you can start doing your magic. 🦄

    if (ctx.args.isNotEmpty) {
      int refId = int.parse(ctx.args[0]);

      // You obiviously don't want the user to be able to refer themselves
      if (refId == ctx.message.from!.id) {
        await ctx.reply("Oh no! You can't refer yourself!");
        return;
      }

      ChatID chatId = ChatID(refId);

      // Get Referrer's profile
      Chat referrer = await chatId.get();

      // Add points to the referrer on database 🎉
      // ...

      // Send a message to the referrer
      await bot.api.sendMessage(
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

    // We can use the `BotLink` class to generate a link to our bot with a start parameter
    BotLink link = BotLink(
      botInfo.username!,
      startParameter: ctx.message.from!.id.toString(),
    );

    await ctx.reply(
      "Here's your referral link. ${link.https}",
    );
  });
}
