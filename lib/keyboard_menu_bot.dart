import 'dart:io';
import 'package:televerse/televerse.dart';

/// Creates the bot instance
final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create the menu
final keyboardMenu = KeyboardMenu(name: "my-menu")
    .text("⚙️ Settings", settingsCallback)
    .row()
    .requestLocation("Send Me Location", locationCallback)
    .oneTime()
    .resized();
// Add more buttons as needed

// Settings callback
Future<void> settingsCallback(Context ctx) async {
  // Reply settings
  await ctx.reply(
    "Here are the bot settings",
  );
}

// Handle the incoming location message
Future<void> locationCallback(Context ctx) async {
  // Reply with the location data
  await ctx.reply(
    "You are at ${ctx.message?.location?.latitude}, ${ctx.message?.location?.longitude}",
  );
}

void main(List<String> args) async {
  // Attach it to the bot
  bot.attachMenu(keyboardMenu);

  // Setup handler for the /start command
  bot.command('start', (ctx) async {
    // Reply with the menu
    await ctx.reply(
      "Hello, choose an option:",
      replyMarkup: keyboardMenu,
    );
  });

  // Start the bot
  await bot.start();
}
