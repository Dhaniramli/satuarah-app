import 'package:get/get.dart';

import '../views/main_navigation_view.dart';

class MainNavigationController extends GetxController {
  MainNavigationView? view;


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  int selectedIndex = 0;
  void incrementCounter() {
    // setState(() {
    selectedIndex++;
    // });
  }

  List menuList = [
    {
      "icon": "assets/beranda.png",
      "label": "Beranda",
    },
    {
      "icon": "assets/riwayat.png",
      "label": "Riwayat",
    },
    {
      "icon": "assets/chat.png",
      "label": "Chat",
    },
    {
      "icon": "assets/profile.png",
      "label": "Profil",
    },
  ];
}
