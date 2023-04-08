# Televerse Examples

This repository contains examples of how to use the [Televerse](https://pub.dev/packages/televerse) package.

## ✨ Examples

Currently, we have the following examples:

### 🤖 Basic Bot
A basic bot that responds to the user with the count of letters in the message they sent. [The code for this example can be found here](./lib/letter_counter.dart).

#### What you'll learn:
1. How to create a simple bot with Televerse.
2. You'll learn about the `command` method that can be used to listen to commands.
3. How to use the `on` method to listen to messages of particular types.

<hr>

### 💰 Referral Bot
A bot that rewards users for inviting new users to the bot. This is also a simple bot that uses just `command` method. [The code for this example can be found here](./lib/referral_bot.dart).

#### What you'll learn:
1. You'll learn about the `command` method that will be used to listen to commands.
2. You'll get a basic understanding of `MessageContext` object and use the `ctx.startParameter` to get the referral code.

<hr>

### 👩🏻‍💼 Mod Helper Bot
A bot that helps moderators in a group to ban users. This bot uses the `command` method to listen to `/ban` commands. [The code for this example can be found here](./lib/mod_helper_bot.dart).

#### What you'll learn:
1. You'll learn about the `command` method that will be used to listen to commands.
2. Context objects and how to use them to get the chat id of the chat where the command was sent.
3. Aliases for API methods and how to use them wisely.

<hr>

## Thank you ❤️

Thank you for using Televerse. If you have any questions, feel free to ask them in the [Televerse Telegram Group](https://t.me/televersedart).

Also, if you have any suggestions, feel free to open an issue or a pull request.

Spread the word about Televerse and help us grow the community.