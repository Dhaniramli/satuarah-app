import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);

  final List<Widget> myChats = List.generate(
    20,
    (index) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: grayDuaColor,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 30,
          child: Image.asset(
            "assets/profile.png",
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "Orang ke ${index + 1}",
          style: textBigBlackStyle.copyWith(fontSize: 19, fontWeight: semiBold),
        ),
        subtitle: Text(
          "Chat orang ke ${index + 1}",
          style: textBigBlackStyle.copyWith(fontSize: 15, fontWeight: regular),
        ),
        trailing: Chip(
          backgroundColor: primaryColor,
          label: Text(
            "3",
            style: textWhiteStyle.copyWith(fontSize: 13),
          ),
        ),
      ),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: myChats.length,
        itemBuilder: (context, index) => myChats[index],
      ),
    );
  }
}
