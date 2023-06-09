import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    Widget dataProfile() {
      return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                radius: 50,
                child: Image.asset(
                  "assets/profile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 19),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Motive",
                  style: textBigBlackStyle.copyWith(
                    fontSize: 19.76,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  "motive@gmail.com",
                  style: textGrayStyle.copyWith(
                    fontSize: 9.3,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buttonEdit() {
      return SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            "Edit Profil",
            style: textWhiteStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget buttonDriver() {
      return SizedBox(
        width: 145,
        height: 42,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            "Daftar Driver",
            style: textWhiteStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget buttonSwitch() {
      return Container(
        height: 96.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 13.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Äktifkan fitur Nebeng",
                    style: textPrimaryStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.0,
                  width: 43.76,
                  child: Obx(
                    () => FlutterSwitch(
                      value: controller.statusSwitch1.value,
                      onToggle: (value) {
                        controller.statusSwitch1.value = value;
                      },
                      activeColor: greenColor,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1.5,
              color: primaryColor,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Äktifkan fitur Nebeng",
                    style: textPrimaryStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26.0,
                  width: 43.76,
                  child: Obx(
                    () => FlutterSwitch(
                      value: controller.statusSwitch2.value,
                      onToggle: (value) {
                        controller.statusSwitch2.value = value;
                      },
                      activeColor: greenColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget buttonLogout() {
      return Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          onPressed: () {
            controller.doLogout();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            "Keluar",
            style: textPrimaryStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dataProfile(),
            const SizedBox(height: 50),
            buttonEdit(),
            const SizedBox(height: 39),
            Text(
              "Ingin menjadi driver? klik dibawah",
              style: textBlackDuaStyle.copyWith(
                fontSize: 13.53,
                fontWeight: regular,
              ),
            ),
            const SizedBox(height: 11),
            buttonDriver(),
            const SizedBox(height: 50),
            buttonSwitch(),
            const SizedBox(height: 130),
            buttonLogout(),
          ],
        ),
      ),
    );
  }
}
