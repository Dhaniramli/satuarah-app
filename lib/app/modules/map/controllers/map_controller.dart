import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/directions_model.dart';

class MapController extends GetxController {
  late GoogleMapController googleMapController;
  late Marker? origin = null;
  late Marker? detination = null;
  late Directions? info = null;

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
    googleMapController.dispose();
    super.onClose();
  }


}
