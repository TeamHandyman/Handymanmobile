import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chatscreen';
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const ChatScreen({this.text, this.date, this.isSentByMe});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var newmessage;
  List<ChatScreen> messages = [
    ChatScreen(
      text: 'Hi',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
      isSentByMe: false,
    ),
    ChatScreen(
      text: 'Hello',
      date: DateTime.now().subtract(Duration(days: 3, minutes: 4)),
      isSentByMe: true,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<ChatScreen, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (ChatScreen message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Theme.of(context).buttonColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, ChatScreen message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(message.text),
                ),
              ),
            ),
          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade300,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Type your message here...',
                    ),
                    onSubmitted: (text) {
                      newmessage = ChatScreen(
                        text: text,
                        date: DateTime.now(),
                        isSentByMe: true,
                      );
                      setState(() {
                        messages.add(newmessage);
                        text = '';
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      messages.add(newmessage);
                    });
                  },
                  icon: Icon(Icons.send, color: Theme.of(context).buttonColor))
            ],
          )
        ],
      ),
    );
  }
}
