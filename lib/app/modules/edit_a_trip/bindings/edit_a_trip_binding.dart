import 'package:get/get.dart';

import '../controllers/edit_a_trip_controller.dart';

class EditATripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditATripController>(
      () => EditATripController(),
    );
  }
}
