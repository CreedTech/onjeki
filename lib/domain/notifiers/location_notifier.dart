import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:onjeki/core/config/map_api_key.dart';

import '../states/location_state.dart';

class LocationNotifier extends StateNotifier<LocationState> {
  final Location _location = Location();

  LocationNotifier() : super(LocationState.initial());

  // Function to get address from latitude and longitude using Dio
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final dio = Dio();
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          // print(data['results'][0]);
          // return data['results'][0]['formatted_address'] ?? 'No address found';
          // Extract address components
           List<dynamic> results = data['results'];

          // Initialize variables for town and country
          String town = 'Town not found';
          String country = 'Country not found';

          // Loop through address components and find town and country
          for (var component in results[0]['address_components']) {
            if (component['types'].contains('postal_town')) {
              town = component['long_name']; // Dartford
            }
            if (component['types'].contains('country')) {
              country = component['long_name']; // United Kingdom
            }
          }

          return '$town, $country'; // Combine town and country
        } else {
          return 'Failed to fetch address';
        }
      } else {
        return 'Failed to fetch address';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<void> initializeLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    // Check for location permission
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Fetch current location
    LocationData? currentLocation = await _location.getLocation();

    // Get the address using lat, long
    final address = await getAddressFromLatLng(
      currentLocation.latitude ?? 0.0,
      currentLocation.longitude ?? 0.0,
    );

    // Update the state with location data and address
    state = state.copyWith(
      serviceEnabled: serviceEnabled,
      permissionGranted: permissionGranted,
      currentLocation: currentLocation,
      address: address,
    );

    //  // Fetch nearby apartments using the current location
    // final apartments = await _apiService.getNearbyApartments(
    //   currentLocation!.latitude!,
    //   currentLocation.longitude!,
    // );

    // state = state.copyWith(
    //   serviceEnabled: serviceEnabled,
    //   permissionGranted: permissionGranted,
    //   currentLocation: currentLocation,
    //   apartments: apartments, // Save the apartments in the state
    // );
  }

  Future<void> refreshLocation() async {
    if (state.permissionGranted == PermissionStatus.granted) {
      LocationData? currentLocation = await _location.getLocation();
      state = state.copyWith(currentLocation: currentLocation);
    }
  }
}
