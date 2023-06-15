import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.chatStream(controller.uidC),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.active) {
            var listDocsChats = snapshot1.data!.docs;
            return ListView.builder(
              // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: listDocsChats.length,
              itemBuilder: (context, index) {
                return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: controller
                      .friendStream(listDocsChats[index]["connection"]),
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.active) {
                      var data = snapshot2.data!.data();
                      return Container(
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
                            "${data?["full_name"]}",
                            style: textBigBlackStyle.copyWith(
                                fontSize: 19, fontWeight: semiBold),
                          ),
                          subtitle: Text(
                            // "Chat orang ke ${index + 1}",
                            "",
                            style: textBigBlackStyle.copyWith(
                                fontSize: 15, fontWeight: regular),
                          ),
                          trailing: listDocsChats[index]["total_unread"]
                                      .toString() ==
                                  "0"
                              ? const SizedBox()
                              : Chip(
                                  backgroundColor: primaryColor,
                                  label: Text(
                                    listDocsChats[index]["total_unread"]
                                        .toString(),
                                    style:
                                        textWhiteStyle.copyWith(fontSize: 13),
                                  ),
                                ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
