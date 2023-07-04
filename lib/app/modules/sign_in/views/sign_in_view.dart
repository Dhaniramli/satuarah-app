import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satuarah/app/routes/app_pages.dart';

import '../../../../theme.dart';
import '../../disclaimer/disclaimer_view.dart';
import '../../reset_password/views/reset_password_view.dart';
import '../../sign_up/views/sign_up_view.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(SignInController());

    Widget disclaimer() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: GestureDetector(
          onTap: () => Get.to(() => const DisclaimerView()),
          child: Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.0,
                  color: grayDuaColor,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Dengan masuk, Anda menyetujui '),
                  TextSpan(
                    text: 'Syarat & Ketentuan\n',
                    style: TextStyle(fontWeight: bold),
                  ),
                  const TextSpan(text: ' serta '),
                  TextSpan(
                    text: 'Privasi',
                    style: TextStyle(fontWeight: bold),
                  ),
                  const TextSpan(text: ' Satuarah.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    Widget formEmail() {
      return SizedBox(
        height: 70,
        child: TextFormField(
          controller: controller.email,
          decoration: InputDecoration(
            icon: const ImageIcon(
              AssetImage(
                "assets/email.png",
              ),
              size: 20,
            ),
            hintText: 'Email',
            hintStyle: textGrayStyle.copyWith(fontSize: 15, fontWeight: medium),
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
        ),
      );
    }

    Widget formPassword() {
      return Obx(
        () => SizedBox(
          height: 70,
          child: TextFormField(
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
              hintStyle:
                  textGrayStyle.copyWith(fontSize: 15, fontWeight: medium),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password wajib diisi';
              }
              return null;
            },
          ),
        ),
      );
    }

    Widget buttonSignIn() {
      return SizedBox(
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
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
                    Get.offAllNamed(Routes.mainNavigation);
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
      );
    }

    Widget footer() {
      return SizedBox(
        height: 30,
        child: Row(
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
      );
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 33, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 33),
                child: Text(
                  "Selamat Datang",
                  style: textBigBlackStyle.copyWith(
                    fontSize: 20,
                    fontWeight: extrabold,
                  ),
                ),
              ),
              const SizedBox(height: 87),
              Form(
                key: formKey,
                child: Column(
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
                    formEmail(),
                    const SizedBox(height: 30),
                    formPassword(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Get.to(() => const ResetPasswordView()),
                      child: Text(
                        "Lupa Password?",
                        style: textPrimaryStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 80),
              buttonSignIn(),
              const SizedBox(height: 16),
              footer(),
              // const SizedBox(height: 5),
              disclaimer(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
