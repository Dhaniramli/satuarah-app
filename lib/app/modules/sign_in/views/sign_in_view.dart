import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  TextFormField(
                    controller: controller.password,
                    decoration: InputDecoration(
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
                ],
              ),
              const SizedBox(height: 197),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.isLoading(true);
                      controller.doLogin();
                      // controller.isLoading(false);
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
                      Get.to(SignUpView());
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
