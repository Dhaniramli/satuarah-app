import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../disclaimer/disclaimer_view.dart';
import '../../loading/loading_view.dart';
import '../controllers/sign_up_controller.dart';
import 'widget/text_form_widget.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

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

    PreferredSize header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "Daftar",
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

    Widget formFullName() {
      return TextFormWidget(
          label: "Nama Lengkap",
          controller: controller.fullName,
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama lengkap wajib diisi';
            }
            return null;
          });
    }

    Widget formEmail() {
      return TextFormWidget(
        label: "Email",
        controller: controller.email,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // Menolak spasi
        ],
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
      );
    }

    Widget formPhoneNumber() {
      return TextFormWidget(
        label: "Nomor Telepon",
        controller: controller.phoneNumber,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
          FilteringTextInputFormatter.digitsOnly,
        ],
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
      );
    }

    Widget formPass() {
      return Obx(
        () => TextFormWidget(
          label: "Password",
          controller: controller.password,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Menolak spasi
          ],
          obscureText: controller.isHiddenOne.value,
          suffixIcon: IconButton(
            onPressed: () {
              controller.isHiddenOne.toggle();
            },
            icon: Icon(
              controller.isHiddenOne.isFalse
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password wajib diisi';
            } else if (value.length < 6) {
              return 'Password harus minimal 6 karakter';
            }
            return null;
          },
        ),
      );
    }

    Widget formPassConfir() {
      return Obx(
        () => TextFormWidget(
          label: "Konfirmasi Password",
          controller: controller.passwordConfirmation,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Menolak spasi
          ],
          obscureText: controller.isHiddenTwo.value,
          suffixIcon: IconButton(
            onPressed: () {
              controller.isHiddenTwo.toggle();
            },
            icon: Icon(
              controller.isHiddenTwo.isFalse
                  ? Icons.remove_red_eye
                  : Icons.remove_red_eye_outlined,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password wajib diisi';
            } else if (value.length < 6) {
              return 'Password harus minimal 6 karakter';
            } else if (value != controller.password.text) {
              return 'Password tidak valid';
            }
            return null;
          },
        ),
      );
    }

    Widget buttonSignIn() {
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
                controller.doSignUp();
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

    return Obx(
      () => controller.isLoading.isFalse
          ? Scaffold(
              appBar: header(),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: white,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Isi data dibawah ini",
                          style: textBigBlackStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(height: 38),
                        formFullName(),
                        const SizedBox(height: 15),
                        formEmail(),
                        const SizedBox(height: 15),
                        formPhoneNumber(),
                        const SizedBox(height: 15),
                        formPass(),
                        const SizedBox(height: 15),
                        formPassConfir(),
                        const SizedBox(height: 59),
                        buttonSignIn(),
                        disclaimer(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const LoadingView(),
    );
  }
}
