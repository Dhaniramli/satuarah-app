import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/modules/home/views/home_view.dart';
import 'package:satuarah/app/modules/main_navigation/controllers/main_navigation_controller.dart';
import 'package:satuarah/app/modules/profile/views/profile_view.dart';

import '../../../../theme.dart';
import '../../../data/models/user_model.dart';
import '../../chat/views/chat_view.dart';
import '../../history/views/history_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView>
    with WidgetsBindingObserver {
  bool isOnline = false;
  int currentIndex = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateUserStatus(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateUserStatus(true);
    } else {
      updateUserStatus(false);
    }
  }

  void updateUserStatus(bool isOnline) {
    final userRef = firestore.collection("users").doc(auth.currentUser!.uid);
    userRef.update({
      'status': isOnline,
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainNavigationController());

    Widget bottomNav() {
      return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 9,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: primaryColor,
                width: 4.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: white,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                print(value);
                currentIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Column(
                      children: [
                        Image.asset(
                          currentIndex == 0
                              ? 'assets/beranda.png'
                              : 'assets/beranda_off.png',
                          width: 30,
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          "Beranda",
                          style: textFontInterStyle.copyWith(
                              color: currentIndex == 0
                                  ? primaryColor
                                  : grayTigaColor,
                              fontSize: 13,
                              fontWeight: semiBold),
                        )
                      ],
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Column(
                      children: [
                        Image.asset(
                          currentIndex == 1
                              ? 'assets/riwayat.png'
                              : 'assets/riwayat_off.png',
                          width: 30,
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          "Perjalanan",
                          style: textFontInterStyle.copyWith(
                              color: currentIndex == 1
                                  ? primaryColor
                                  : grayTigaColor,
                              fontSize: 13,
                              fontWeight: semiBold),
                        )
                      ],
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: Column(
                      children: [
                        Image.asset(
                          currentIndex == 2
                              ? 'assets/chat.png'
                              : 'assets/chat_off.png',
                          width: 30,
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          "Chat",
                          style: textFontInterStyle.copyWith(
                              color: currentIndex == 2
                                  ? primaryColor
                                  : grayTigaColor,
                              fontSize: 13,
                              fontWeight: semiBold),
                        )
                      ],
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: controller.userCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text("Error");
                      if (!snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Column(
                            children: [
                              Image.asset(
                                currentIndex == 3
                                    ? 'assets/profile_on.png'
                                    : 'assets/profile.png',
                                width: 30,
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                "Profil",
                                style: textFontInterStyle.copyWith(
                                    color: currentIndex == 3
                                        ? primaryColor
                                        : grayTigaColor,
                                    fontSize: 13,
                                    fontWeight: semiBold),
                              )
                            ],
                          ),
                        );
                      }
                      if (snapshot.data?.data != null) {
                        Map<String, dynamic>? data =
                            (snapshot.data!.data() as Map<String, dynamic>?);
                        data!["id"] = snapshot.data!.id;

                        UserModel user = UserModel(
                          email: data["email"] ?? "",
                          fullName: data["full_name"] ?? "",
                          idUser: data["id_user"] ?? "",
                          merekKendaraan: data["merek_kendaraan"] ?? "",
                          nomorKtp: data["nomor_ktp"] ?? "",
                          nomorPlat: data["nomor_plat"] ?? "",
                          nomorSim: data["nomor_sim"] ?? "",
                          phoneNumber: data["phone_number"] ?? "",
                          userAs: data["user_as"] ?? "",
                          photo: data["photo"] ?? "",
                        );

                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Column(
                            children: [
                              user.photo == ""
                                  ? Image.asset(
                                      currentIndex == 3
                                          ? 'assets/profile_on.png'
                                          : 'assets/profile.png',
                                      width: 30,
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: currentIndex == 3
                                              ? primaryColor
                                              : grayTigaColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          user.photo,
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 3.0),
                              Text(
                                "Profil",
                                style: textFontInterStyle.copyWith(
                                    color: currentIndex == 3
                                        ? primaryColor
                                        : grayTigaColor,
                                    fontSize: 13,
                                    fontWeight: semiBold),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  label: ''),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomeView();
        case 1:
          return HistoryView();
        case 2:
          return ChatView();
        case 3:
          return const ProfileView();
        default:
          return HomeView();
      }
    }

    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: bottomNav(),
      body: body(),
      extendBody: true,
    );
  }
}
