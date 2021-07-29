import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class MyInbox extends StatefulWidget {
  @override
  _MyInboxState createState() => _MyInboxState();
}

class _MyInboxState extends State<MyInbox> {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Inbox'),
        backgroundColor: Color(0xFFC71632),
      ),
      body: FutureBuilder(
          future: fetchSms(),
          builder: (context, snapshot) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      messages[index].isRead
                          ? Icons.mark_chat_read
                          : Icons.markunread,
                      size: 20.0,
                      color: messages[index].isRead
                          ? Color(0xFFC71632)
                          : Colors.black,
                    ),
                    title: Text(messages[index].sender),
                    subtitle: Text(
                      messages[index].body,
                      maxLines: 20,
                      style: TextStyle(),
                    ),
                    minLeadingWidth: 20,
                  ),
                );
              },
            );
          }),
    );
  }

  Future fetchSms() async {
    messages = await query.getAllSms;
  }
}
