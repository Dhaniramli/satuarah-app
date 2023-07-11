import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderingMapController extends GetxController {
  late GoogleMapController? googleMapController;
  Marker? origin;
  Marker? detination;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    googleMapController!.dispose();
    super.onClose();
  }
}
