import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../theme.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/models/user_model.dart';
import '../controllers/ordering_map_controller.dart';

class OrderingMapView extends StatefulWidget {
  const OrderingMapView({
    Key? key,
  }) : super(key: key);

  @override
  _OrderingMapViewState createState() => _OrderingMapViewState();
}

final TripModel? trip = Get.arguments;
CameraPosition _initialCameraPosition = CameraPosition(
  target: LatLng(
    double.parse(trip!.latitudeStart),
    double.parse(trip!.longitudeStart),
  ),
  zoom: 11.5,
);

class _OrderingMapViewState extends State<OrderingMapView> {
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
    polylines[id] = polyline;
    setState(() {});
  }

  Future<void> _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDmdU24RknAfHnoYzuA2ekpD4yvGOTI9vQ', // Ganti dengan kunci API Google Maps yang valid -5.291972, 119.427223
      PointLatLng(double.parse(trip!.latitudeStart),
          double.parse(trip!.longitudeStart)),
      PointLatLng(double.parse(trip!.latitudeFinish),
          double.parse(trip!.longitudeFinish)),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    setState(() {
      _addPolyline();
    });
  }

  @override
  void initState() {
    super.initState();
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    final controllerC = Get.put(OrderingMapController());

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: white,
        title: Text('Peta',
            style: textPrimaryStyle.copyWith(fontWeight: FontWeight.normal)),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              controllerC.googleMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      double.parse(trip!.latitudeStart),
                      double.parse(trip!.longitudeStart),
                    ),
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
          TextButton(
            onPressed: () {
              controllerC.googleMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      double.parse(trip!.latitudeFinish),
                      double.parse(trip!.longitudeFinish),
                    ),
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
              setState(() {
                _addPolyline();
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId(
                  'origin',
                ),
                infoWindow: const InfoWindow(title: 'Awal'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                position: LatLng(
                  double.parse(trip!.latitudeStart),
                  double.parse(trip!.longitudeStart),
                ),
              ),
              Marker(
                markerId: const MarkerId('destination'),
                infoWindow: const InfoWindow(title: 'Tujuan'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                position: LatLng(
                  double.parse(trip!.latitudeFinish),
                  double.parse(trip!.longitudeFinish),
                ),
              ),
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
                        '          ${trip!.thoroughfareStart}, ${trip!.subLocalityStart}, ${trip!.localityStart}, ${trip!.subAdministrativeAreaStart}, ',
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
                        'Berhenti di,',
                        style: textGrayStyle.copyWith(
                          fontSize: 13,
                          fontWeight: bold,
                        ),
                      ),
                      TextScroll(
                        '          ${trip!.thoroughfareFinish}, ${trip!.subLocalityFinish}, ${trip!.localityFinish}, ${trip!.subAdministrativeAreaFinish}, ',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
