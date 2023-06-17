import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../../data/models/user_model.dart';
import '../controllers/edit_profile_controller.dart';
import 'widgets/text_form_widget.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    final formKey = GlobalKey<FormState>();
    final UserModel dataUser = Get.arguments;

    if (controller.email.text == "") {
      controller.email.text = dataUser.email;
    }
    if (controller.fullName.text == "") {
      controller.fullName.text = dataUser.fullName;
    }
    if (controller.phoneNumber.text == "") {
      controller.phoneNumber.text = dataUser.phoneNumber;
    }
    if (controller.nomorKtp.text == "") {
      controller.nomorKtp.text = dataUser.nomorKtp;
    }
    if (controller.nomorSim.text == "") {
      controller.nomorSim.text = dataUser.nomorSim;
    }
    if (controller.nomorPlat.text == "") {
      controller.nomorPlat.text = dataUser.nomorPlat;
    }
    if (controller.merekKendaraan.text == "") {
      controller.merekKendaraan.text = dataUser.merekKendaraan;
    }

    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "Edit Profil",
            style: textWhiteStyle.copyWith(
              fontSize: 19.3,
              fontWeight: semiBold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      );
    }

    Widget buttonEdit() {
      return SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (controller.isLoading.isFalse) {
                controller.isLoading.toggle();
                setState(() {
                  dataUser.userAs == "driver"
                      ? controller.doEditProfileDriver()
                      : controller.doEditProfile();
                });
                controller.isLoading(false);
              }
            }
          },
          child: Text(
            'Simpan',
            style: textWhiteStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 155,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/profile.png",
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 80, top: 70),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: GestureDetector(
                              onTap: () {
                                // controller.selectImage();
                              },
                              child: Image.asset(
                                "assets/edit.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextFormWidget(
                  label: "Email",
                  hintText: "Email",
                  controller: controller.email,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email wajib diisi';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormWidget(
                  label: "Nama",
                  hintText: "Nama Lengkap",
                  controller: controller.fullName,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormWidget(
                  label: "Nomor Telepon",
                  hintText: "Nomor Telepon",
                  controller: controller.phoneNumber,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon wajib diisi';
                    } else if (!RegExp(r'^(?:\+62|62|0)[2-9]{1}[0-9]+$')
                        .hasMatch(value)) {
                      return 'Format nomor telepon tidak valid';
                    }
                    return null;
                  },
                ),
                dataUser.userAs != "driver"
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          label: "KTP",
                          hintText: "Nomor KTP",
                          controller: controller.nomorKtp,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor KTP wajib diisi';
                            } else if (!RegExp(r'^[0-9]{16}$')
                                .hasMatch(value)) {
                              return 'Format nomor KTP tidak valid. Nomor KTP harus terdiri dari 16 digit angka.';
                            }
                            return null;
                          },
                        ),
                      ),
                dataUser.userAs != "driver"
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          label: "SIM",
                          hintText: "Nomor SIM",
                          controller: controller.nomorSim,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor SIM wajib diisi';
                            }
                            // else if (!RegExp(r'^[A-Z]{1}[0-9]{5}[A-Z]{1}$')
                            //     .hasMatch(value)) {
                            //   return 'Format nomor SIM tidak valid. Nomor SIM harus terdiri dari 1 huruf kapital di awal, 5 digit angka, dan 1 huruf kapital di akhir.';
                            // }
                            return null;
                          },
                        ),
                      ),
                dataUser.userAs != "driver"
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          label: "Merek",
                          hintText: "Merek Kendaraan",
                          controller: controller.merekKendaraan,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Merek kendaraan wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ),
                dataUser.userAs != "driver"
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormWidget(
                          label: "Plat Kendaraan",
                          hintText: "Nomor Plat",
                          controller: controller.nomorPlat,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nomor Plat wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ),
                const SizedBox(height: 50),
                buttonEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
