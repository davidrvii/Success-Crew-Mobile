/// File: lib/core/utils/location_helper.dart
/// Generated Documentation for location_helper.dart

import 'package:geolocator/geolocator.dart';

/// Helper class to handle GPS location geofencing checks for shop attendance.
/// Class representing `LocationHelper`.
/// Auto-generated class documentation.
class LocationHelper {
  // Success Comp Cibubur coordinates (Komplek Ruko Citra Gran)
  static const double cibuburLat = -6.3824;
  static const double cibuburLng = 106.9269;

  // Success Comp Bogor coordinates (Jl. Ciremei Ujung Ruko Warung Jambu)
  static const double bogorLat = -6.5744;
  static const double bogorLng = 106.8080;

  // Maximum allowed distance in meters from either shop location (150 meters)
  static const double maxDistanceMeters = 150.0;

  /// Check if the user's current GPS position is within [maxDistanceMeters] (150m)
  /// of either Success Comp Cibubur or Success Comp Bogor.
  ///
  /// Requests location permissions if they are not already granted.
  /// Returns `true` if in range, `false` otherwise (or in case of errors/denied permissions).
  static Future<bool> isWithinRange() async {
    try {
      // 1. Verify if location services are enabled on the device
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // 2. Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      // 3. Fail if permissions are permanently denied
      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      // 4. Retrieve the current high-accuracy GPS position of the device
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // 5. Calculate geodesic distance to Success Comp Cibubur
      final distanceToCibubur = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        cibuburLat,
        cibuburLng,
      );

      // 6. Calculate geodesic distance to Success Comp Bogor
      final distanceToBogor = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        bogorLat,
        bogorLng,
      );

      // 7. Return true if user is within the geofenced radius of at least one shop
      return distanceToCibubur <= maxDistanceMeters || distanceToBogor <= maxDistanceMeters;
    } catch (_) {
      // Return false on timeout, API failures, or plugin errors
      return false;
    }
  }
}
