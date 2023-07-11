import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../make_a_trip/views/make_a_trip_view.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../theme.dart';
import '../../../data/models/user_model.dart';
import '../controllers/map_controller.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

const _initialCameraPosition = CameraPosition(
  target: LatLng(-5.161635, 119.435995),
  zoom: 11.5,
);

class _MapViewState extends State<MapView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<Marker> _markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  void _addPolyline() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  Future<void> _getPolyline() async {
    final controllerC = Get.put(MapController());

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDmdU24RknAfHnoYzuA2ekpD4yvGOTI9vQ',
      PointLatLng(controllerC.latitudeStart, controllerC.longitudeStart),
      PointLatLng(controllerC.latitudeFinish, controllerC.longitudeFinish),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        _addPolyline();
      });
    }
    setState(() {
      _addPolyline();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controllerC = Get.put(MapController());
    final UserModel? dataUser = Get.arguments;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: white,
        title: Text('Pilih Rute',
            style: textPrimaryStyle.copyWith(fontWeight: FontWeight.normal)),
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
        actions: [
          if (controllerC.origin != null)
            TextButton(
              onPressed: () {
                controllerC.googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: controllerC.origin!.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('Awal'),
            ),
          if (controllerC.detination != null)
            TextButton(
              onPressed: () {
                controllerC.googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: controllerC.detination!.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('Tujuan'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            polylines: Set<Polyline>.of(polylines.values),
            compassEnabled: false,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              controllerC.googleMapController = controller;
              _addPolyline();
            },
            markers: {
              if (controllerC.origin != null) controllerC.origin!,
              if (controllerC.detination != null) controllerC.detination!,
            },
            onTap: (LatLng location) {
              _addMarker(location);
              _getPlaceName(location);
            },
          ),
          Positioned(
            top: 20.0,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.15,
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: black,
                          offset: const Offset(0, 2),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Berangkat dari,',
                        style: textGrayStyle.copyWith(
                          fontSize: 13,
                          fontWeight: bold,
                        ),
                      ),
                      TextScroll(
                        controllerC.placeNameStart == ''
                            ? controllerC.placeName != ""
                                ? '       ${controllerC.placeNamethoroughfare}, ${controllerC.placesubLocality}, ${controllerC.placeName}, ${controllerC.placeNamesubAdministrativeArea}'
                                : 'Pilih lokasi awal'
                            : '       ${controllerC.placeNamethoroughfareStart}, ${controllerC.placesubLocalityStart}, ${controllerC.placeNameStart}, ${controllerC.placeNamesubAdministrativeAreaStart}',
                        mode: TextScrollMode.endless,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(50, 0)),
                        style: textWhiteStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                controllerC.placeNameStart != ''
                    ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.15,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                                color: black,
                                offset: const Offset(0, 2),
                                blurRadius: 6.0)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Berhenti di,',
                              style: textGrayStyle.copyWith(
                                fontSize: 13,
                                fontWeight: bold,
                              ),
                            ),
                            TextScroll(
                              controllerC.placeNameFinish == ''
                                  ? controllerC.placeName != ""
                                      ? '       ${controllerC.placeNamethoroughfare}, ${controllerC.placesubLocality}, ${controllerC.placeName}, ${controllerC.placeNamesubAdministrativeArea}'
                                      : 'Pilih lokasi tujuan'
                                  : '       ${controllerC.placeNamethoroughfareFinish}, ${controllerC.placesubLocalityFinish}, ${controllerC.placeNameFinish}, ${controllerC.placeNamesubAdministrativeAreaFinish}',
                              mode: TextScrollMode.endless,
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(50, 0)),
                              style: textWhiteStyle.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: ElevatedButton(
              onPressed: controllerC.placeName != ""
                  ? () {
                      if (controllerC.placeNameStart == '') {
                        setState(() {
                          controllerC.placeNameStart = controllerC.placeName;
                          controllerC.placeNamesubAdministrativeAreaStart =
                              controllerC.placeNamesubAdministrativeArea;
                          controllerC.placeNamethoroughfareStart =
                              controllerC.placeNamethoroughfare;
                          controllerC.placesubLocalityStart =
                              controllerC.placesubLocality;

                          controllerC.latitudeStart = controllerC.latitude;
                          controllerC.longitudeStart = controllerC.longitude;
                          controllerC.placeName = '';
                        });
                      } else if (controllerC.placeNameFinish == '') {
                        setState(() {
                          controllerC.placeNameFinish = controllerC.placeName;
                          controllerC.placeNamesubAdministrativeAreaFinish =
                              controllerC.placeNamesubAdministrativeArea;
                          controllerC.placeNamethoroughfareFinish =
                              controllerC.placeNamethoroughfare;
                          controllerC.placesubLocalityFinish =
                              controllerC.placesubLocality;

                          controllerC.latitudeFinish = controllerC.latitude;
                          controllerC.longitudeFinish = controllerC.longitude;
                          _getPolyline();
                        });
                      } else {
                        Get.to(() => MakeATripView(
                              dataUser: dataUser,
                              latitudeStart: controllerC.latitudeStart,
                              longitudeStart: controllerC.longitudeStart,
                              placeNameStart: controllerC.placeNameStart,
                              placeNamesubAdministrativeAreaStart: controllerC
                                  .placeNamesubAdministrativeAreaStart,
                              placeNamethoroughfareStart:
                                  controllerC.placeNamethoroughfareStart,
                              placesubLocalityStart:
                                  controllerC.placesubLocalityStart,
                              latitudeFinish: controllerC.latitudeFinish,
                              longitudeFinish: controllerC.longitudeFinish,
                              placeNameFinish: controllerC.placeNameFinish,
                              placeNamesubAdministrativeAreaFinish: controllerC
                                  .placeNamesubAdministrativeAreaFinish,
                              placeNamethoroughfareFinish:
                                  controllerC.placeNamethoroughfareFinish,
                              placesubLocalityFinish:
                                  controllerC.placesubLocalityFinish,
                            ));
                      }
                    }
                  : controllerC.placeNameFinish != ''
                      ? () {
                          Get.to(() => MakeATripView(
                                dataUser: dataUser,
                                latitudeStart: controllerC.latitudeStart,
                                longitudeStart: controllerC.longitudeStart,
                                placeNameStart: controllerC.placeNameStart,
                                placeNamesubAdministrativeAreaStart: controllerC
                                    .placeNamesubAdministrativeAreaStart,
                                placeNamethoroughfareStart:
                                    controllerC.placeNamethoroughfareStart,
                                placesubLocalityStart:
                                    controllerC.placesubLocalityStart,
                                latitudeFinish: controllerC.latitudeFinish,
                                longitudeFinish: controllerC.longitudeFinish,
                                placeNameFinish: controllerC.placeNameFinish,
                                placeNamesubAdministrativeAreaFinish:
                                    controllerC
                                        .placeNamesubAdministrativeAreaFinish,
                                placeNamethoroughfareFinish:
                                    controllerC.placeNamethoroughfareFinish,
                                placesubLocalityFinish:
                                    controllerC.placesubLocalityFinish,
                              ));
                        }
                      : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120.0, 48.0),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: bold,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: controllerC.placeNameStart == ''
                  ? const Text('Pilih Sebagai Lokasi Awal')
                  : controllerC.placeNameFinish == ''
                      ? const Text('Pilih Sebagai Lokasi Tujuan')
                      : const Text('Selanjutnya'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          controllerC.googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          );
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng location) {
    final controllerC = Get.put(MapController());

    if (controllerC.placeNameStart == '') {
      setState(() {
        controllerC.origin = Marker(
          markerId: const MarkerId(
            'origin',
          ),
          infoWindow: const InfoWindow(title: 'Awal'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: location,
        );
        // reset destination
        controllerC.detination = null;
      });
    } else if (controllerC.placeNameFinish == '') {
      setState(() {
        controllerC.detination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Tujuan'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: location,
        );
      });
    }

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
        ),
      );
    });
  }

  void _getPlaceName(LatLng location) async {
    final controllerC = Get.put(MapController());
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        controllerC.placeName = placemark.locality ?? '';
        controllerC.placeNamesubAdministrativeArea =
            placemark.subAdministrativeArea ?? '';
        controllerC.placeNamethoroughfare = placemark.thoroughfare ?? '';
        controllerC.placesubLocality = placemark.subLocality ?? '';

        controllerC.latitude = location.latitude;
        controllerC.longitude = location.longitude;

        setState(() {});

        // _showSnackbar('Nama: ${controllerC.placeName}');
        // _showSnackbar('Latitude: ${controllerC.latitude}');
        // _showSnackbar('Longitude: ${controllerC.longitude}');
      }
    } catch (e) {
      Get.snackbar(
        "Terjadi Kesalahan",
        "$e",
        duration: const Duration(seconds: 2),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: primaryColor,
        colorText: Colors.white,
        borderRadius: 10,
      );
    }
  }

  // void _showSnackbar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }
}
