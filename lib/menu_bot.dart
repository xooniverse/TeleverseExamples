import 'dart:io';
import 'package:televerse/televerse.dart';

/// Creates the bot instance
final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create the menu
final startMenu = InlineMenu(name: "Start Menu")
    .text("Hello", 'hello', helloCallback)
    .row()
    .text("Start", 'start', firstCallback)
    .text("Finish", 'finish', finishCallback);

/// This is a general bot that tests different features of the library.
void main() async {
  // Attach it to the bot
  bot.attachMenu(startMenu);

  // Register handler for the /start commmand
  bot.command('start', (ctx) {
    // Reply with the menu
    ctx.reply(
      "Hello, choose an option:",
      replyMarkup: startMenu,
    );
  });

  // Start the bot and listen for updates
  await bot.start();
}

// When a user clicks on the "Hello" button, the bot will answer with "Cool!"
void helloCallback(Context ctx) async {
  await ctx.answerCallbackQuery(text: "Cool!");
}

// When a user clicks on the "First" button, the bot will answer with
// "That's what you like :)" in an alert
void firstCallback(Context ctx) async {
  await ctx.answerCallbackQuery(
    text: "That's what you like :)",
    showAlert: true,
  );
}

// When a user clicks on the "Second" button, the bot will edit the message
// with "How was that?"
void finishCallback(Context ctx) async {
  await ctx.editMessageText("How was that?");
}
