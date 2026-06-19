import 'package:geolocator/geolocator.dart';

class LocationHelper {
  // Success Comp Cibubur coordinates
  static const double cibuburLat = -6.3824;
  static const double cibuburLng = 106.9269;

  // Success Comp Bogor coordinates
  static const double bogorLat = -6.5744;
  static const double bogorLng = 106.8080;

  static const double maxDistanceMeters = 150.0;

  /// Check if the user is within 150 meters of Success Comp Cibubur or Success Comp Bogor
  static Future<bool> isWithinRange() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      final distanceToCibubur = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        cibuburLat,
        cibuburLng,
      );

      final distanceToBogor = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        bogorLat,
        bogorLng,
      );

      return distanceToCibubur <= maxDistanceMeters || distanceToBogor <= maxDistanceMeters;
    } catch (_) {
      return false;
    }
  }
}
