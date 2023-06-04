import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../loading/loading_view.dart';
import '../controllers/register_driver_controller.dart';
import 'widget/text_form_widget.dart';

class RegisterDriverView extends GetView<RegisterDriverController> {
  const RegisterDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterDriverController());
    final formKey = GlobalKey<FormState>();

    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "Daftar Driver",
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

    Widget buttonRegister() {
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
                controller.doRegisterDriver();
                controller.isLoading(false);
              }
            }
          },
          child: Text(
            'Daftar',
            style: textWhiteStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    return Obx(() => controller.isLoading.isFalse
        ? Scaffold(
            appBar: header(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Isi data dibawah ini",
                        style: textBigBlackStyle.copyWith(
                          fontSize: 20,
                          fontWeight: bold,
                        ),
                      ),
                      const SizedBox(height: 38),
                      TextFormWidget(
                        label: "KTP",
                        hintText: "Nomor KTP",
                        controller: controller.nomorKtp,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor KTP wajib diisi';
                          } else if (!RegExp(r'^[0-9]{16}$').hasMatch(value)) {
                            return 'Format nomor KTP tidak valid. Nomor KTP harus terdiri dari 16 digit angka.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormWidget(
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
                      const SizedBox(height: 15),
                      TextFormWidget(
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
                      const SizedBox(height: 15),
                      TextFormWidget(
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
                      const SizedBox(height: 100),
                      buttonRegister(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const LoadingView());
  }
}
