import 'dart:io';
import 'package:televerse/televerse.dart';

/// Creates the bot instance
final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create the menu
final keyboardMenu = KeyboardMenu(name: "my-menu")
    .text("⚙️ Settings", settingsCallback)
    .row()
    .requestLocation("Send Me Location", locationCallback)
    .resized();
// Add more buttons as needed

// Settings callback
Future<void> settingsCallback(MessageContext ctx) async {
  // Reply settings
  await ctx.reply(
    "Here are the bot settings",
  );
}

// Handle the incoming location message
Future<void> locationCallback(MessageContext ctx) async {
  // Reply with the location data
  await ctx.reply(
    "You are at ${ctx.message.location!.latitude}, ${ctx.message.location!.longitude}",
  );
}

void main(List<String> args) {
  // Attach it to the bot
  bot.attachMenu(keyboardMenu);

  // Start the bot and listen for /start command updates
  bot.start((ctx) {
    // Reply with the menu
    ctx.reply(
      "Hello, choose an option:",
      replyMarkup: keyboardMenu,
    );
  });
}
