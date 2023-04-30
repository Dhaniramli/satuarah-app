import 'package:get/get.dart';

import '../controllers/popular_route_controller.dart';

class PopularRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopularRouteController>(
      () => PopularRouteController(),
    );
  }
}
