import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 30,
          backgroundColor: primaryColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
          title: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/profile.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Asrul",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textWhiteStyle.copyWith(
                          fontWeight: semiBold, fontSize: 19),
                    ),
                    Text(
                      "Online",
                      style: textWhiteStyle.copyWith(
                          fontWeight: semiBold, fontSize: 14),
                    )
                  ],
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
              child: TextFormField(
                autocorrect: false,
                // controller: controller.message,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: grayDuaColor,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Ketik Pesan....',
                ),
              ),
            ),
            // const SizedBox(width: 20),
            // GestureDetector(
            //   onTap: () {},
            //   child: Image.asset(
            //     'assets/picture/icon_send.png',
            //     width: 40,
            //     height: 40,
            //   ),
            // )
          ],
        ),
      );
    }

    Widget content() {
      return Container(
          // margin: const EdgeInsets.all(15),
          // child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          //   stream: controller.streamChat(chatRoomid),
          //   builder: (context, snapshot) {
          //     // print("1");
          //     // print(snapshot.data);
          //     if (snapshot.connectionState == ConnectionState.active) {
          //       var allData = snapshot.data?.docs.length;
          //       Timer(
          //           Duration.zero,
          //           () => controller.scrollC
          //               .jumpTo(controller.scrollC.position.maxScrollExtent));
          //       return ListView.builder(
          //         controller: controller.scrollC,
          //         itemCount: allData,
          //         itemBuilder: (context, index) {
          //           Map<String, dynamic> map =
          //               snapshot.data?.docs[index].data() as Map<String, dynamic>;
          //           if (index == 0) {
          //             return Column(
          //               children: [
          //                 Text(
          //                   "${map["groupTime"]}",
          //                   style: textStyleBlack.copyWith(
          //                       fontSize: 13, fontWeight: medium),
          //                 ),
          //                 messages(context, map),
          //               ],
          //             );
          //           } else {
          //             if (snapshot.data?.docs[index]["groupTime"] ==
          //                 snapshot.data?.docs[index - 1]["groupTime"]) {
          //               return messages(context, map);
          //             } else {
          //               return Column(
          //                 children: [
          //                   Text(
          //                     "${map["groupTime"]}",
          //                     style: textStyleBlack.copyWith(
          //                         fontSize: 13, fontWeight: medium),
          //                   ),
          //                   messages(context, map),
          //                 ],
          //               );
          //             }
          //           }
          //         },
          //       );
          //     }
          //     return Container();
          //   },
          // ),
          );
    }

    return Scaffold(
      appBar: header(),
      body: Column(
        children: [
          // Expanded(child: content()),
          chatInput(),
        ],
      ),
    );
  }
}
