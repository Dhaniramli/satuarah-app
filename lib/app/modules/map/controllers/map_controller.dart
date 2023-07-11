import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late GoogleMapController? googleMapController;
  Marker? origin;
  Marker? detination;
  // Directions? info;

  String placeName = '';
  String placeNamesubAdministrativeArea = '';
  String placeNamethoroughfare = '';
  String placesubLocality = '';

  double latitude = 0.0;
  double longitude = 0.0;

  String placeNameStart = '';
  String placeNamesubAdministrativeAreaStart = '';
  String placeNamethoroughfareStart = '';
  String placesubLocalityStart = '';

  String placeNameFinish = '';
  String placeNamesubAdministrativeAreaFinish = '';
  String placeNamethoroughfareFinish = '';
  String placesubLocalityFinish = '';

  double latitudeStart = 0.0;
  double longitudeStart = 0.0;
  double latitudeFinish = 0.0;
  double longitudeFinish = 0.0;

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
