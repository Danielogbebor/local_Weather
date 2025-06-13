import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:local_eather/model/weather_models.dart';

class WeatherService{
  final  String apiKey ;
  static const  _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

WeatherService(this.apiKey);
   Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse('$_baseUrl?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);



    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }


   Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;
    return city ?? '';
  }
}