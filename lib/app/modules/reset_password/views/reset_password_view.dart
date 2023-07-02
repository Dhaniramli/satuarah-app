import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "",
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

    Widget formEmail() {
      return TextFormField(
        controller: controller.email,
        obscureText: false,
        decoration: InputDecoration(
          hintText: "Email",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.94),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email wajib diisi';
          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              .hasMatch(value)) {
            return 'Format email tidak valid';
          }
          return null;
        },
      );
    }

    Widget buttonReset() {
      return SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          onPressed: () async {
            controller.send();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Obx(
            () => Text(
              controller.isLoading.isFalse ? 'Kirim' : 'Memuat...',
              style: textWhiteStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: grayColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Masukan alamat email anda untuk melakukan pengaturan ulang password',
                          style: TextStyle(fontWeight: bold, fontSize: 15),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              formEmail(),
              const SizedBox(height: 50),
              buttonReset(),
            ],
          ),
        ),
      ),
    );
  }
}
