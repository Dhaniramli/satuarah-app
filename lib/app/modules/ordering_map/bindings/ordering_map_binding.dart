import 'package:get/get.dart';

import '../controllers/ordering_map_controller.dart';

class OrderingMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderingMapController>(
      () => OrderingMapController(),
    );
  }
}
