import 'package:flutter/material.dart';
import 'package:theOne/freedomchat/constants.dart';
import 'package:theOne/freedomchat/models/ChatMessage.dart';
import 'package:theOne/freedomchat/screens/messages/components/chat_input_field.dart';
import 'package:theOne/freedomchat/screens/messages/components/message.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: demoChatMessage.length,
                itemBuilder: (context, index) =>
                    Message(message: demoChatMessage[index]),
              ),
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}
