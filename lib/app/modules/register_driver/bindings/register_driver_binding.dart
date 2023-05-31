import 'package:get/get.dart';

import '../controllers/register_driver_controller.dart';

class RegisterDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterDriverController>(
      () => RegisterDriverController(),
    );
  }
}
