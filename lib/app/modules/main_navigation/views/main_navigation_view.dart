import 'package:flutter/material.dart';
import 'package:satuarah/app/modules/home/views/home_view.dart';
import 'package:satuarah/app/modules/profile/views/profile_view.dart';

import '../../../../theme.dart';
import '../../chat/views/chat_view.dart';
import '../../history/views/history_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                  icon: Container(
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
