import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) =>
            controllerC.googleMapController = controller,
        markers: {
          if (controllerC.origin != null) controllerC.origin!,
          if (controllerC.detination != null) controllerC.detination!,
        },
        onTap: addMarker,
        // onLongPress: addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          controllerC.googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
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
    }
  }
}
