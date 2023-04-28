import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../components/customTextField.dart';

String city = '';

class LocationService {
  double? lat;
  double? long;
  Future<Map<String, dynamic>> geo() async {
    List<Placemark> placemarks1 = []; // Current Location
    List<Placemark> placemarks2 = []; // Searched Location
    String? SelectedCity = cityName;
    String CurrentCity = '';
    Map<String, dynamic> info = {};
    // Check if Location Services In On or not on Phone
    bool LocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    LocationServiceEnabled == true
        ? print("Location ON")
        : print("Location OFF");

    // Check if App has Permission to Access to Location and this will Respone by
    //four answers:
    // 1- Always    2- while in use     3- denied     4- denied for ever
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request Premission From User For Access Location
      permission = await Geolocator.requestPermission();
    }

// Calculate Distance Between to Locations in meter Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Get Current Location [Lat & Long]
      // var accuracy = await Geolocator.getLocationAccuracy();
      var cl = await Geolocator.getCurrentPosition().then((value) => value);

      // Translate [Lat & Long] to Readable Info
      // Currnet City
      placemarks1 = await placemarkFromCoordinates(cl.latitude, cl.longitude,
          localeIdentifier: 'en');

      CurrentCity = SelectedCity ?? placemarks1[0].locality!;

      List<Location> locations = await locationFromAddress(CurrentCity, localeIdentifier:'en');

      lat = locations[0].latitude;
      long = locations[0].longitude;

      // Searched City
      placemarks2 = await placemarkFromCoordinates(lat!, long!, localeIdentifier:'en');

      info = {
        'Lat': lat ?? cl.latitude,
        'Long': long ?? cl.longitude,
        "Country": placemarks2[0].country,
        'City': placemarks2[0].administrativeArea
      };

      city = placemarks2[0].locality!  == "" ? placemarks2[0].administrativeArea! : placemarks2[0].locality!;
      // Country = placemarks2[0].country!;
      print(
          "Country :${placemarks1[0].country}, City: ${placemarks1[0].locality}");
      // print(
      //     "Country :${placemarks2[0].country}, City: ${placemarks2[0].subAdministrativeArea}");
      // CountryName = placemarks[1].country!;
      print(placemarks2);
      // print(placemarks[2].administrativeArea!);
      print('lat: ${info['Lat']} , long: ${info['Long']}');
      return info;
    }
    return {};
  }

 Future<Position> liveLocation() async {
    Position  cl = await Geolocator.getCurrentPosition().then((value) => value);
    List<Placemark> placemarks2 = [];
    placemarks2 = await placemarkFromCoordinates(cl.latitude, cl.longitude,
        localeIdentifier: 'en');

    city = placemarks2[0].locality!;

    return cl;
  }
}
