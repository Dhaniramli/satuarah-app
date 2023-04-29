import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/routes/app_pages.dart';

import '../../../../theme.dart';
import '../../sign_up/views/sign_up_view.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 33, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang",
                style: textBigBlackStyle.copyWith(
                  fontSize: 20,
                  fontWeight: extrabold,
                ),
              ),
              const SizedBox(height: 87),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Silahkan Login",
                    style: textGrayStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 38),
                  TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                        icon: const ImageIcon(
                          AssetImage(
                            "assets/email.png",
                          ),
                          size: 20,
                        ),
                        hintText: 'Email',
                        hintStyle: textGrayStyle.copyWith(
                            fontSize: 15, fontWeight: medium)),
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => TextField(
                      controller: controller.password,
                      obscureText: controller.isHidden.value,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isHidden.toggle();
                            },
                            icon: Icon(
                              controller.isHidden.isFalse
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                            ),
                          ),
                          icon: const ImageIcon(
                            AssetImage(
                              "assets/password.png",
                            ),
                            size: 20,
                          ),
                          hintText: 'Password',
                          hintStyle: textGrayStyle.copyWith(
                              fontSize: 15, fontWeight: medium)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 197),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      if (controller.email.text.isNotEmpty &&
                          controller.password.text.isNotEmpty) {
                        controller.isLoading(true);
                        Map<String, dynamic> hasil = await controller.signIn(
                          controller.email.text,
                          controller.password.text,
                        );
                        controller.isLoading(false);
                        if (hasil["error"] == true) {
                          Get.snackbar(
                            "Terjadi Kesalahan",
                            hasil["message"],
                            duration: const Duration(seconds: 2),
                            snackStyle: SnackStyle.FLOATING,
                            backgroundColor: primaryColor,
                            colorText: Colors.white,
                            borderRadius: 10,
                          );
                        } else {
                          Get.offAllNamed(Routes.home);
                        }
                      } else {
                        Get.snackbar(
                          "Terjadi Kesalahan",
                          "email dan password wajib diisi",
                          duration: const Duration(seconds: 2),
                          snackStyle: SnackStyle.FLOATING,
                          backgroundColor: primaryColor,
                          colorText: Colors.white,
                          borderRadius: 10,
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Obx(
                    () => Text(
                      controller.isLoading.isFalse ? 'Masuk' : 'Memuat...',
                      style: textWhiteStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum Punya Akun?",
                    style: textGrayStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpView());
                    },
                    child: Text(
                      'Daftar',
                      style: textPrimaryStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
