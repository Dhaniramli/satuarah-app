import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool statusSwitch1 = false.obs;
  RxBool statusSwitch2 = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  doLogout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.signIn);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
