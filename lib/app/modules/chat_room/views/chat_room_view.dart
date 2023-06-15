import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  final TripModel? trip;
  final String? chatRoomid;
  final String? friendEmail;

  const ChatRoomView({
    super.key,
    this.chatRoomid,
    this.trip,
    this.friendEmail,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatRoomController());

    CollectionReference users = controller.firestore.collection("users");

    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () async {
              await users
                  .doc(controller.auth.currentUser!.uid)
                  .collection("chats")
                  .doc(chatRoomid)
                  .update({
                "total_unread": 0,
              });
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
          title: Row(
            children: [
              ClipOval(
                child: Container(
                  color: textGrayStyle.backgroundColor,
                  child: StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: controller.streamFriendData("$friendEmail"),
                    builder: ((context, snapFriend) {
                      if (snapFriend.connectionState ==
                          ConnectionState.active) {
                        // var dataFriend =
                        //     snapFriend.data!.data() as Map<String, dynamic>;
                        // if (dataFriend["photo"] == "") {
                          return Image.asset(
                            'assets/profile.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          );
                        // } else {
                        //   return Image.network(
                        //     "${dataFriend["photo"]}",
                        //     height: 50,
                        //     width: 50,
                        //     fit: BoxFit.cover,
                        //   );
                        // }
                      }
                      return Image.asset(
                        'assets/profile.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: controller.streamFriendData("$friendEmail"),
                  builder: ((context, snapFriend) {
                    if (snapFriend.connectionState == ConnectionState.active) {
                      var dataFriend =
                          snapFriend.data!.data() as Map<String, dynamic>;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${dataFriend["full_name"]}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textWhiteStyle.copyWith(
                                fontWeight: semiBold, fontSize: 19),
                          ),
                          // dataFriend["status"] == true
                          //     ? Text(
                          //         "Online",
                          //         style: textStyleGreen.copyWith(
                          //             fontWeight: light, fontSize: 14),
                          //       )
                          //     : Text(
                          //         "Offline",
                          //         style: textStyleOrange.copyWith(
                          //             fontWeight: light, fontSize: 14),
                          //       )
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Loading...",
                          style: textWhiteStyle.copyWith(
                              fontWeight: medium, fontSize: 14),
                        ),
                        Text(
                          "Loading...",
                          style: textGrayStyle.copyWith(
                              fontWeight: light, fontSize: 14),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget chatInput() {
      return Container(
        margin: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: containerInputColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller.message,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Ketik Pesan....'),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                controller.newChat(
                    controller.auth.currentUser!.uid,
                    chatRoomid.toString(),
                    controller.message.text,
                    trip!.idDriver);
                controller.message.clear();
              },
              child: Image.asset(
                'assets/icon_send.png',
                width: 40,
                height: 40,
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        margin: const EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamChat(chatRoomid!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var allData = snapshot.data?.docs.length;
              Timer(
                  Duration.zero,
                  () => controller.scrollC
                      .jumpTo(controller.scrollC.position.maxScrollExtent));
              return ListView.builder(
                controller: controller.scrollC,
                itemCount: allData,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  if (index == 0) {
                    return Column(
                      children: [
                        Text(
                          "${map["groupTime"]}",
                          style: textBlackDuaStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                        ),
                        messages(context, map),
                      ],
                    );
                  } else {
                    if (snapshot.data?.docs[index]["groupTime"] ==
                        snapshot.data?.docs[index - 1]["groupTime"]) {
                      return messages(context, map);
                    } else {
                      return Column(
                        children: [
                          Text(
                            "${map["groupTime"]}",
                            style: textBlackDuaStyle.copyWith(
                                fontSize: 13, fontWeight: medium),
                          ),
                          messages(context, map),
                        ],
                      );
                    }
                  }
                },
              );
            }
            return Container();
          },
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await users
            .doc(controller.auth.currentUser!.uid)
            .collection("chats")
            .doc(chatRoomid)
            .update({
          "total_unread": 0,
        });
        return true;
      },
      child: Scaffold(
        appBar: header(),
        body: Column(
          children: [
            Expanded(child: content()),
            chatInput(),
          ],
        ),
      ),
    );
  }
}

Widget messages(BuildContext context, Map<String, dynamic> map) {
  final controller = Get.put(ChatRoomController());

  return Container(
    alignment: map['pengirim'] == controller.auth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft,
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: map['pengirim'] == controller.auth.currentUser!.uid
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: map['pengirim'] == controller.auth.currentUser!.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: map['pengirim'] == controller.auth.currentUser!.uid
                      ? primaryColor
                      : primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(8),
                      topRight: const Radius.circular(8),
                      bottomLeft: Radius.circular(
                          map['pengirim'] == controller.auth.currentUser!.uid
                              ? 8
                              : 0),
                      bottomRight: Radius.circular(
                          map['pengirim'] == controller.auth.currentUser!.uid
                              ? 0
                              : 8)),
                ),
                child: Text(
                  map["msg"],
                  style: textWhiteStyle.copyWith(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          "${map['jm']}",
          style: textBlackDuaStyle.copyWith(fontSize: 11),
        ),
      ],
    ),
  );
}
