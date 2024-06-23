import 'dart:io';
import 'package:televerse/televerse.dart';

final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create a middleware or import one if already built

class Logger implements Middleware {
  // The `fn` is the middleware function that will be excuted over the context.
  // Calling the `next` function will execute the following middleware or the main handler.
  @override
  void handle(Context ctx, NextFunction next) {
    // Suppose we're just printing the update id
    print(ctx.update.updateId);

    // Move to the next handler, if you skip this invocation, the
    // middleware chain is ended here.
    next();
  }
}

void main(List<String> args) {
  // Attach the middleware to the bot
  bot.use(Logger());

  // Continue setting up your bot

  bot.command('start', (ctx) async {
    await ctx.reply("Hello World");
  });

  bot.help((ctx) async {
    await ctx.reply("Here to help!");
  });

  // Now on all succeeding handler calls, the update id is logged.

  bot.start();
}
