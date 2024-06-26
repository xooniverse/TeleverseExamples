import 'dart:io';
import 'package:televerse/televerse.dart';

void main(List<String> args) async {
  // Bind the server to an available port
  var server = await HttpServer.bind(InternetAddress.anyIPv6, 8080);

  // Create a webhook fetcher instance
  final webhook = Webhook(
    server,
    url: "https://mydomain.com",
  );

  // Create a bot instance using the webhook fetcher
  final bot = Bot(
    Platform.environment["BOT_TOKEN"]!,
    fetcher: webhook,
  );

  // Define a command handler for the 'start' command
  bot.command('start', (ctx) async {
    await ctx.reply("Hello World!");
  });

  // Start the bot
  bot.start();
}
