// import 'package:dio/dio.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../../data/models/directions_model.dart';

// class DirectionsRepository {
//   String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

//   final Dio diO;

//   DirectionsRepository({Dio? dio}) : diO = dio ?? Dio();

//   Future<Directions?> getDirections({
//     required LatLng origin,
//     required LatLng destination,
//   }) async {
//     final response = await diO.get(baseUrl, queryParameters: {
//       'origin': '${origin.latitude},${origin.longitude}',
//       'destination': '${destination.latitude},${destination.longitude}',
//       'key': 'AIzaSyDmdU24RknAfHnoYzuA2ekpD4yvGOTI9vQ',
//     });
//     // check if response success
//     if (response.statusCode == 200) {
//       return Directions.fromMap(response.data);
//     }
//     return null;
//   }
// }
