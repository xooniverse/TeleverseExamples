import 'dart:io';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create a Transformer or import one if already built

class AutoReplyEnforcer implements Transformer {
  @override
  Future<Map<String, dynamic>> transform(
    APICaller call,
    APIMethod method,
    Payload payload,
  ) async {
    final isSendMethod = APIMethod.sendMethods.contains(method);
    final isNotChatAction = method != APIMethod.sendChatAction;

    if (isSendMethod && isNotChatAction) {
      payload.params["reply_markup"] = ForceReply().toJson();
    }

    return await call(method, payload);
  }
}

void main(List<String> args) {
  // Attach the Transformer to the bot.
  bot.use(AutoReplyEnforcer());

  // Continue setting up your bot

  bot.command('start', (ctx) async {
    // User will be forced to reply to this "Hello World" message.
    await ctx.reply("Hello World");
  });

  bot.help((ctx) async {
    // Similarly, here as well.
    await ctx.reply("Here to help!");
  });

  bot.start();
}
