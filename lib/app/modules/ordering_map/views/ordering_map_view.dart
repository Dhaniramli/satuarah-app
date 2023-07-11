import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../theme.dart';
import '../controllers/ordering_map_controller.dart';

class OrderingMapView extends StatefulWidget {
  final String? latitudeStart;
  final String? latitudeFinish;
  final String? longitudeStart;
  final String? longitudeFinish;
  final String? localityStart;
  final String? localityFinish;
  final String? subAdministrativeAreaStart;
  final String? subAdministrativeAreaFinish;
  final String? thoroughfareStart;
  final String? thoroughfareFinish;
  final String? subLocalityStart;
  final String? subLocalityFinish;

  const OrderingMapView({
    Key? key,
    this.latitudeStart,
    this.latitudeFinish,
    this.longitudeStart,
    this.longitudeFinish,
    this.localityStart,
    this.localityFinish,
    this.subAdministrativeAreaStart,
    this.subAdministrativeAreaFinish,
    this.thoroughfareStart,
    this.thoroughfareFinish,
    this.subLocalityStart,
    this.subLocalityFinish,
  }) : super(key: key);

  @override
  _OrderingMapViewState createState() => _OrderingMapViewState();
}

class _OrderingMapViewState extends State<OrderingMapView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      'AIzaSyDmdU24RknAfHnoYzuA2ekpD4yvGOTI9vQ',
      PointLatLng(double.parse(widget.latitudeStart!),
          double.parse(widget.longitudeStart!)),
      PointLatLng(double.parse(widget.latitudeFinish!),
          double.parse(widget.longitudeFinish!)),
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
        title: Text('Rute',
            style: textPrimaryStyle.copyWith(fontWeight: bold)),
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
                      double.parse(widget.latitudeStart!),
                      double.parse(widget.longitudeStart!),
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
                      double.parse(widget.latitudeFinish!),
                      double.parse(widget.longitudeFinish!),
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
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(widget.latitudeStart!),
                double.parse(widget.longitudeStart!),
              ),
              zoom: 11.5,
            ),
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
                  double.parse(widget.latitudeStart!),
                  double.parse(widget.longitudeStart!),
                ),
              ),
              Marker(
                markerId: const MarkerId('destination'),
                infoWindow: const InfoWindow(title: 'Tujuan'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                position: LatLng(
                  double.parse(widget.latitudeFinish!),
                  double.parse(widget.longitudeFinish!),
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
                        '          ${widget.thoroughfareStart}, ${widget.subLocalityStart}, ${widget.localityStart}, ${widget.subAdministrativeAreaStart}, ',
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
                        '          ${widget.thoroughfareFinish}, ${widget.subLocalityFinish}, ${widget.localityFinish}, ${widget.subAdministrativeAreaFinish}, ',
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
