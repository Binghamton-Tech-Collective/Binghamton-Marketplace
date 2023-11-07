import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";

class ChatMessage {
  final String text;
  final DateTime date;
  final bool fromMe;
  const ChatMessage({
    required this.text,
    required this.date,
    required this.fromMe,
  });
}

final messages = [
  ChatMessage(text: "Nice doing business with you!", date: DateTime.now().subtract(Duration(minutes: 28)), fromMe: true),
  ChatMessage(text: "Great, see you there", date: DateTime.now().subtract(Duration(minutes: 33)), fromMe: false),
  ChatMessage(text: "The Union, of course!", date: DateTime.now().subtract(Duration(minutes: 41)), fromMe: true),
  ChatMessage(text: "I was thinking around like 3pm? Where do you want to meet?", date: DateTime.now().subtract(Duration(minutes: 45)), fromMe: false),
  ChatMessage(text: "Yes! When do you want to pick it up?", date: DateTime.now().subtract(Duration(minutes: 50)), fromMe: true),
  ChatMessage(text: "Hey, is this for sale?", date: DateTime.now().subtract(Duration(hours: 1)), fromMe: false),
];

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Chat with Levi Lesches")),
    bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
      BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Messages"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search Products"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ]),
    body: Column(children: [
            SizedBox(height: 45),
      CircleAvatar(
        radius: 72, 
        backgroundImage: NetworkImage(
          "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
          // scale: 5,
        ),
      ),
      SizedBox(height: 16),
      Text("Levi Lesches", style: context.textTheme.headlineLarge),
      SizedBox(height: 8),
      Expanded(child: ListView(      
      reverse: true,
      children: [
        for (final message in messages) Container(
          alignment: message.fromMe ? Alignment.centerRight : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: message.fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: message.fromMe ? Colors.lightBlue.shade300 : Colors.blueGrey.shade300,
                ),
                child: Text(message.text),
                // margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              SizedBox(height: 8),
              Text(MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(message.date))),
            ]
          )
        ),
      ],
    )),
    ]),
  );
}
