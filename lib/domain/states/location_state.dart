import 'package:location/location.dart';

class LocationState {
  final bool serviceEnabled;
  final PermissionStatus permissionGranted;
  final LocationData? currentLocation;
  final String? address; // Add the address field

  LocationState({
    required this.serviceEnabled,
    required this.permissionGranted,
    required this.currentLocation,
    this.address, // Add address to the constructor
  });

  LocationState.initial()
      : serviceEnabled = false,
        permissionGranted = PermissionStatus.denied,
        currentLocation = null,
        address = null; // Initialize address as null

  LocationState copyWith({
    bool? serviceEnabled,
    PermissionStatus? permissionGranted,
    LocationData? currentLocation,
    String? address, // Add address as an optional parameter
  }) {
    return LocationState(
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      currentLocation: currentLocation ?? this.currentLocation,
      address: address ?? this.address, // Set address if provided
    );
  }
}

class Apartment {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int price;
  final String image;

  Apartment({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.image,
  });
}
