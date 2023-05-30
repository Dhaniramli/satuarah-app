import 'package:get/get.dart';

import '../controllers/ordering_controller.dart';

class OrderingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderingController>(
      () => OrderingController(),
    );
  }
}
