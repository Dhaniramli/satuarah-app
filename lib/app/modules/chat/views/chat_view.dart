import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/chat_controller.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    Map<String, dynamic> userMap = {};

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
                          onTap: () async {
                            await controller.firestore
                                .collection('users')
                                .where(
                                  "full_name",
                                  isEqualTo: "${data?["full_name"]}",
                                )
                                .get()
                                .then((value) {
                              setState(() {
                                userMap = value.docs[0].data();
                              });
                            });

                            // print("UID CHAT ${listDocsChats[index].id}");
                            // print(controller.auth.currentUser!.uid);
                            // print(userMap);
                            // print("${data?["id_user"]}");

                            controller.selectChat(
                                listDocsChats[index].id,
                                controller.auth.currentUser!.uid,
                                userMap,
                                "${data?["id_user"]}");

                            // controller.addNewConnection(
                            //   "${data?["id_user"]}",
                            //   userMap,
                            // );
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            child: data?["photo"] == ""
                                ? Image.asset(
                                    "assets/profile.png",
                                    fit: BoxFit.cover,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      data?["photo"],
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
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
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/nothing.png",
                            width: 50.0,
                            height: 90.0,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Tidak ada tebengan",
                            style: textGrayStyle.copyWith(fontWeight: semiBold),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/nothing.png",
                  width: 50.0,
                  height: 90.0,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                Text(
                  "Tidak ada tebengan",
                  style: textGrayStyle.copyWith(fontWeight: semiBold),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
