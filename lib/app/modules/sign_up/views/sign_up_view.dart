import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';
import '../../loading/loading_view.dart';
import '../controllers/sign_up_controller.dart';
import 'widget/text_field_widget.dart';
import 'widget/text_form_widget.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

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
        label: "Email",
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
      );
    }

    Widget formEmail() {
      return TextFieldWidget(
        label: "Nama Lengkap",
        controller: controller.fullName,
        obscureText: false,
      );
    }

    Widget formPhoneNumber() {
      return TextFieldWidget(
        label: "Nomor Telepon",
        controller: controller.phoneNumber,
        obscureText: false,
      );
    }

    Widget formPass() {
      return Obx(
        () => TextFieldWidget(
          label: "Password",
          controller: controller.password,
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
        ),
      );
    }

    Widget formPassConfir() {
      return Obx(
        () => TextFieldWidget(
          label: "Konfirmasi Password",
          controller: controller.passwordConfirmation,
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
                        const SizedBox(height: 109),
                        buttonSignIn(),
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
