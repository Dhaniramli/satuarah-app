import 'package:get/get.dart';

import '../controllers/leaving_today_controller.dart';

class LeavingTodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeavingTodayController>(
      () => LeavingTodayController(),
    );
  }
}
