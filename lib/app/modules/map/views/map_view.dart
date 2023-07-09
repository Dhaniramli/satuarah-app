import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../theme.dart';
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
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final controllerC = Get.put(MapController());

    return Scaffold(
      key: _scaffoldKey,
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
              child: const Text('origin'),
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
              child: const Text('destination'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) =>
                controllerC.googleMapController = controller,
            markers: {
              if (controllerC.origin != null) controllerC.origin!,
              if (controllerC.detination != null) controllerC.detination!,
            },
            onTap: (LatLng location) {
              _addMarker(location);
              _getPlaceName(location);
            },
            // onLongPress: addMarker,
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
          position: location,
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
          position: location,
        );
      });
    }

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: location,
        ),
      );
    });
  }

  void _getPlaceName(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String placeName = placemark.locality ?? '';
        // String placeName = placemark.subAdministrativeArea ?? '';

        double latitude = location.latitude;
        double longitude = location.longitude;

        setState(() {
          _selectedLocation = LatLng(latitude, longitude);
        });

        _showSnackbar('Nama: $placeName');
        _showSnackbar('Latitude: $latitude');
        _showSnackbar('Longitude: $longitude');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
