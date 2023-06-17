// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../register_driver/views/register_driver_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    Widget buttonDriver() {
      return SizedBox(
        width: 145,
        height: 42,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => RegisterDriverView());
          },
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
                    "Äktifkan Notifikasi",
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
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: controller.userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (!snapshot.hasData) return const Text("No Data");
          Map<String, dynamic>? data =
              (snapshot.data!.data() as Map<String, dynamic>?);
          data!["id"] = snapshot.data!.id;

          UserModel user = UserModel(
            email: data["email"],
            fullName: data["full_name"],
            idUser: data["id_user"],
            merekKendaraan: data["merek_kendaraan"] ?? "",
            nomorKtp: data["nomor_ktp"] ?? "",
            nomorPlat: data["nomor_plat"] ?? "",
            nomorSim: data["nomor_sim"] ?? "",
            phoneNumber: data["phone_number"],
            userAs: data["user_as"],
            photo: data["photo"],
          );

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: controller.userCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return const Text("Error");
                    if (!snapshot.hasData) return const Text("No Data");
                    if (snapshot.data!.data != null) {
                      Map<String, dynamic>? data =
                          (snapshot.data!.data() as Map<String, dynamic>?);
                      data!["id"] = snapshot.data!.id;

                      UserModel user = UserModel(
                        email: data["email"],
                        fullName: data["full_name"],
                        idUser: data["id_user"],
                        merekKendaraan: data["merek_kendaraan"] ?? "",
                        nomorKtp: data["nomor_ktp"] ?? "",
                        nomorPlat: data["nomor_plat"] ?? "",
                        nomorSim: data["nomor_sim"] ?? "",
                        phoneNumber: data["phone_number"],
                        userAs: data["user_as"],
                        photo: data["photo"],
                      );

                      return Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          children: [
                            Column(
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
                                user.userAs == "driver"
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Text(
                                          "Driver",
                                          style: textPrimaryStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: semiBold),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(width: 19),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  style: textBigBlackStyle.copyWith(
                                    fontSize: 19.76,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  user.email,
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
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.to(() => EditProfileView());
                      Get.toNamed(Routes.EDIT_PROFILE, arguments: user);
                    },
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
                ),
                user.userAs == "costumer"
                    ? Padding(
                        padding: const EdgeInsets.only(top: 39),
                        child: Text(
                          "Ingin menjadi driver? klik dibawah",
                          style: textBlackDuaStyle.copyWith(
                            fontSize: 13.53,
                            fontWeight: regular,
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 11),
                user.userAs == "costumer" ? buttonDriver() : const SizedBox(),
                const SizedBox(height: 50),
                buttonSwitch(),
                const SizedBox(height: 130),
                buttonLogout(),
              ],
            ),
          );
        },
      ),
    );
  }
}
