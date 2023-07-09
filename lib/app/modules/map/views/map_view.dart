import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satuarah/app/modules/map/views/directions_repository.dart';
import 'package:satuarah/theme.dart';

import '../controllers/map_controller.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

const _initialCameraPosition = CameraPosition(
  target: LatLng(-5.161635, 119.435995),
  zoom: 11.5,
);



class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    final controllerC = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          'MapView',
          style: textPrimaryStyle.copyWith(),
        ),
        centerTitle: false,
        actions: [
          if (controllerC.origin != null)
            TextButton(
              onPressed: () {
                controllerC.googleMapController.animateCamera(
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
              child: const Text('origin'),
            ),
          if (controllerC.detination != null)
            TextButton(
              onPressed: () {
                controllerC.googleMapController.animateCamera(
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
              child: const Text('destination'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) =>
                controllerC.googleMapController = controller,
            markers: {
              if (controllerC.origin != null) controllerC.origin!,
              if (controllerC.detination != null) controllerC.detination!,
            },
            polylines: {
              if (controllerC.info != null)
                Polyline(
                  polylineId: PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: controllerC.info!.polylinePoints!
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onTap: addMarker,
            // onLongPress: addMarker,
          ),
          if (controllerC.info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: black,
                        offset: const Offset(0, 2),
                        blurRadius: 6.0)
                  ],
                ),
                child: Text(
                  '${controllerC.info!.totalDistance}, ${controllerC.info!.totalDuration}',
                  style: textBlackDuaStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          controllerC.googleMapController.animateCamera(
            controllerC.info != null
                ? CameraUpdate.newLatLngBounds(controllerC.info!.bounds!, 100.0)
                : CameraUpdate.newCameraPosition(_initialCameraPosition),
          );
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void addMarker(LatLng pos) async {
    final controllerC = Get.put(MapController());
    if (controllerC.origin == null ||
        (controllerC.origin != null && controllerC.detination != null)) {
      setState(() {
        controllerC.origin = Marker(
          markerId: const MarkerId(
            'origin',
          ),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // reset destination
        controllerC.detination = null;
        controllerC.info = null;
      });
    } else {
      setState(() {
        controllerC.detination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get Directions
      final directions = await DirectionsRepository().getDirections(
          origin: controllerC.origin!.position,
          destination: controllerC.detination!.position);
      setState(() {
        controllerC.info = directions!;
      });
    }
  }
}
