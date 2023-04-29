import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:satuarah/app/modules/loading/loading_view.dart';
import 'package:satuarah/theme.dart';

import '../controllers/sign_up_controller.dart';
import 'widget/text_field_widget.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Obx(
      () => controller.isLoading.isFalse
          ? Scaffold(
              appBar: PreferredSize(
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
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: white,
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
                      TextFieldWidget(
                        label: "Nama Lengkap",
                        controller: controller.fullName,
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        label: "Email",
                        controller: controller.email,
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        label: "Nomor Telepon",
                        controller: controller.phoneNumber,
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      Obx(
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
                      ),
                      const SizedBox(height: 15),
                      Obx(
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
                      ),
                      const SizedBox(height: 109),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            if (controller.isLoading.isFalse) {
                              controller.isLoading.toggle();
                              controller.doSignUp();
                              controller.isLoading(false);
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const LoadingView(),
    );
  }
}
