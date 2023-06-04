import 'package:get/get.dart';

import '../controllers/make_a_trip_controller.dart';

class MakeATripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeATripController>(
      () => MakeATripController(),
    );
  }
}
