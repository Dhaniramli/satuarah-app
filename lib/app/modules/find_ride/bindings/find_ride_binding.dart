import 'package:get/get.dart';

import '../controllers/find_ride_controller.dart';

class FindRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindRideController>(
      () => FindRideController(),
    );
  }
}
