import 'dart:io';
import 'package:televerse/televerse.dart';

void main(List<String> arguments) {
  Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

  Map<String, String> gifs = {
    "Iron Man": "https://media.giphy.com/media/8xomIW1DRelmo/giphy.gif",
    "Captain America": "https://media.giphy.com/media/qadvd1vBaZBBu/giphy.gif",
    "Thor":
        "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWViZDdiN2Q0YWQzZDQ2ZDQyOWE1ZjYxZWZhZTQwMDA5ZjJmMGZiMCZjdD1n/qWoubkSvQxN1C/giphy.gif",
    "Hulk": "https://media.giphy.com/media/xFBnkMvpTM6m4/giphy.gif",
    "Black Widow": "https://media.giphy.com/media/fcGuamXXetf5S/giphy.gif",
    "Oh no": "https://media.giphy.com/media/9Fticsj7froxbpd5Sg/giphy.gif",
  };

  bot.start((ctx) async {
    final name = ctx.message.from?.firstName ?? "Anonymous";
    await ctx.reply("Hello $name!");

    Keyboard optionsKeyboard = Keyboard()
        .addText("Iron Man")
        .addText("Captain America")
        .row()
        .addText("Thor")
        .addText("Hulk")
        .row()
        .addText("Black Widow")
        .resized();

    await ctx.reply(
      "Who's your favorite Avenger?",
      replyMarkup: optionsKeyboard,
    );
  });

  final regexp = RegExp(r"^(Iron Man|Captain America|Thor|Hulk|Black Widow)$");

  bot.hears(regexp, (ctx) {
    final hero = ctx.matches?[0].group(0) ?? "Oh no";

    final gif = gifs[hero] ?? gifs["Oh no"]!;

    ctx.replyWithAnimation(InputFile.fromUrl(gif));
  });
}
