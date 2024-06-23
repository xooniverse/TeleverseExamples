import 'dart:io';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

final bot = Bot(Platform.environment["BOT_TOKEN"]!);

// Create a Transformer or import one if already built

class AutoReplier implements Transformer {
  @override
  Map<String, dynamic> transform(
    APIMethod method,
    Map<String, dynamic> payload,
    Context? ctx,
  ) {
    // We'll force the user to reply to the message bot sends

    final isSendMethod = APIMethod.sendMethods.contains(method);
    final isNotChatAction = method != APIMethod.sendChatAction;

    // If bot is calling a `send` method and if it is not `sendChatAction`
    // Then we edit the payload and attach the force reply markup.
    if (isSendMethod && isNotChatAction) {
      payload["reply_markup"] = ForceReply().toJson();
    }

    // Return the modified payload
    return payload;
  }
}

void main(List<String> args) {
  // Attach the Transformer to the bot.
  bot.use(AutoReplier());

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
