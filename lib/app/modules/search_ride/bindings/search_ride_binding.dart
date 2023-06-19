import 'package:get/get.dart';

import '../controllers/search_ride_controller.dart';

class SearchRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchRideController>(
      () => SearchRideController(),
    );
  }
}
