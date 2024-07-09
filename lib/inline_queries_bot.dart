import 'dart:io';
import 'package:televerse/televerse.dart';

final bot = Bot(Platform.environment["BOT_TOKEN"]!);

void main(List<String> args) async {
  bot.onInlineQuery((ctx) async {
    final builder = InlineQueryResultBuilder();
    for (int i = 0; i < catPics.length; i++) {
      builder.photo(
        "cat$i",
        catPics[i],
        catPics[i],
        replyMarkup: InlineKeyboard().addUrl(
          "Source",
          catPics[i],
        ),
      );
    }

    await ctx.answerInlineQuery(builder.build());
  });

  bot.command('start', (ctx) async {
    final menu =
        InlineMenu().switchInlineQueryCurrentChat("Switch to Inline", 'cats');
    await ctx.reply(
      "Tap on the bellow buttons to enter inline mode and see cool results.",
      replyMarkup: menu,
    );
  });

  await bot.start();
}

/// Cat Pics to be shown in the 'cats' inline query
final catPics = [
  "https://i.natgeofe.com/n/4cebbf38-5df4-4ed0-864a-4ebeb64d33a4/NationalGeographic_1468962_4x3.jpg",
  "https://www.thesprucepets.com/thmb/OoMBiCxD3B02Jx-WO9dmY0DAaaI=/4000x0/filters:no_upscale():strip_icc()/cats-recirc3_2-1f5de201af94447a9063f83249260aff.jpg",
  "https://d2zp5xs5cp8zlg.cloudfront.net/image-53908-800.jpg",
  "https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg",
  "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png",
];
