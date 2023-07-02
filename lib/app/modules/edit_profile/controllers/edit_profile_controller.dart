import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

import '../../../../theme.dart';

class EditProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  RxBool isLoading = false.obs;

  late TextEditingController email;
  late TextEditingController fullName;
  late TextEditingController phoneNumber;
  late TextEditingController nomorKtp;
  late TextEditingController nomorSim;
  late TextEditingController nomorPlat;
  late TextEditingController merekKendaraan;
  late ImagePicker pickerC;
  XFile? pickedImage;

  updatePhotoUrl(String url) async {
    CollectionReference users = firestore.collection("users");

    await users.doc(auth.currentUser!.uid).update({
      "photo": url,
    });
  }

  Future<String?> uploadImage(String uid) async {
    Reference storageRef = storage.ref("$uid.png");
    File file = File(pickedImage!.path);

    try {
      final dataUpload = await storageRef.putFile(file);

      // print(dataUpload);
      final photoUrl = await storageRef.getDownloadURL();
      deleteImage();
      return photoUrl;
    } catch (err) {
      // print(err);
      return null;
    }
  }

  deleteImage() {
    pickedImage = null;
    update();
  }

  Future<void> selectImage() async {
    try {
      final dataImage = await pickerC.pickImage(source: ImageSource.gallery);
      if (dataImage != null) {
        // print(dataImage.name);
        pickedImage = dataImage;
      }
      update();
    } catch (err) {
      // print(err);
      pickedImage = null;
      update();
    }
  }

  doEditProfile() async {
    try {
      await firestore.collection("users").doc(auth.currentUser!.uid).update({
        "full_name": fullName.text,
        "email": email.text,
        "phone_number": phoneNumber.text,
      });
      Get.snackbar(
        "Berhasil",
        "Data Profil diUbah",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );
    } on Exception catch (err) {
     Get.snackbar("Terjadi kesalahan", "$err");
    }
  }

  doEditProfileDriver() async {
    try {
      await firestore.collection("users").doc(auth.currentUser!.uid).update({
        "full_name": fullName.text,
        "email": email.text,
        "phone_number": phoneNumber.text,
        "nomor_ktp": nomorKtp.text,
        "nomor_sim": nomorSim.text,
        "nomor_plat": nomorPlat.text,
        "merek_kendaraan": merekKendaraan.text,
      });
      Get.snackbar(
        "Berhasil",
        "Data Profil diUbah",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: white,
        colorText: primaryColor,
        borderRadius: 10,
      );
    } on Exception catch (err) {
      Get.snackbar("Terjadi kesalahan", "$err");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    fullName = TextEditingController();
    phoneNumber = TextEditingController();
    nomorKtp = TextEditingController();
    nomorSim = TextEditingController();
    nomorPlat = TextEditingController();
    merekKendaraan = TextEditingController();
    pickerC = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    fullName.dispose();
    phoneNumber.dispose();
    nomorKtp.dispose();
    nomorSim.dispose();
    nomorPlat.dispose();
    merekKendaraan.dispose();
    super.onClose();
  }
}
