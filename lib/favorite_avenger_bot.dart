import 'dart:io';
import 'package:televerse/televerse.dart';

void main(List<String> arguments) async {
  Bot bot = Bot(Platform.environment["BOT_TOKEN"]!);

  // All the different gifs for the avengers
  Map<String, String> gifs = {
    "Iron Man": "https://media.giphy.com/media/8xomIW1DRelmo/giphy.gif",
    "Captain America": "https://media.giphy.com/media/qadvd1vBaZBBu/giphy.gif",
    "Thor":
        "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWViZDdiN2Q0YWQzZDQ2ZDQyOWE1ZjYxZWZhZTQwMDA5ZjJmMGZiMCZjdD1n/qWoubkSvQxN1C/giphy.gif",
    "Hulk": "https://media.giphy.com/media/xFBnkMvpTM6m4/giphy.gif",
    "Black Widow": "https://media.giphy.com/media/fcGuamXXetf5S/giphy.gif",
    "Oh no": "https://media.giphy.com/media/9Fticsj7froxbpd5Sg/giphy.gif",
  };

  // Register a handler for the /start command
  bot.command('start', (ctx) async {
    // Get and greet the user by their first name
    final name = ctx.message?.from?.firstName ?? "Anonymous";
    await ctx.reply("Hello $name!");

    // ✨ Keyboard class can be used to create a keyboard
    // Keyboard class is chainable, and hence you can simply call the methods one after another
    // to create a keyboard. The `resized` method is used to resize the keyboard to necessary size.
    //
    // Play around with the keyboard options to see how it works.
    Keyboard optionsKeyboard = Keyboard()
        .text("Iron Man")
        .text("Captain America")
        .row()
        .text("Thor")
        .text("Hulk")
        .row()
        .text("Black Widow")
        .resized();

    // Now we can simply send the keyboard as reply markup to the user
    await ctx.reply(
      "Who's your favorite Avenger?",
      replyMarkup: optionsKeyboard,
    );
  });

  // Rgexp to match the avenger names
  final regexp = RegExp(r"^(Iron Man|Captain America|Thor|Hulk|Black Widow)$");

  // ✨ The `hears` method can be used to register a handler for a specific text message
  // that matches the given regular expression.
  //
  // So whenever the user sends a message that matches the given regular expression,
  // the handler will be called.
  bot.hears(regexp, (ctx) async {
    // 👀 The [Context.matches] property will be automatically set to the list of
    // matches from the regular expression.
    final hero = ctx.matches[0].group(0) ?? "Oh no";

    // Get the gif for the hero & send it to the user
    final gif = gifs[hero] ?? gifs["Oh no"]!;
    await ctx.replyWithAnimation(InputFile.fromUrl(gif));
  });

// Start the bot
  await bot.start();
}
