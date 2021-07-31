import 'package:flutter/material.dart';
import 'package:theOne/freedomchat/components/filled_outline_button.dart';
import 'package:theOne/freedomchat/constants.dart';
import 'package:theOne/freedomchat/models/Chat.dart';
import 'package:theOne/freedomchat/screens/chats/components/chat_card.dart';
import 'package:theOne/freedomchat/screens/messages/message_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutLineButton(
                press: () {},
                text: "Recent Message",
                isFilled: false,
              ),
              SizedBox(width: kDefaultPadding),
              FillOutLineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen())),
            ),
          ),
        ),
      ],
    );
  }
}
