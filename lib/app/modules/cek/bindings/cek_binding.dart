import 'package:get/get.dart';

import '../controllers/cek_controller.dart';

class CekBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CekController>(
      () => CekController(),
    );
  }
}
