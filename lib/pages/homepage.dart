import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:local_eather/model/weather_models.dart';
import 'package:local_eather/services/weather_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _weatherService = WeatherService("2278457f888222c1609393f4c9054448");
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition) {
      case 'Clear':
        return 'assets/sunny.json';
      case 'Clouds':
        return 'assets/cloudy.json';
      case 'Rain':
        return 'assets/rainy.json';
      case 'Snow':
        return 'assets/snow.json';
      case 'Thunderstorm':
        return 'assets/thunder.json';
      case 'Drizzle':
        return 'assets/drizzle.json';
      case 'Mist':
      case 'Fog':
      case 'Haze':
        return 'assets/animations/mist.json';
      default:
        return 'assets/animations/default.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        
        child: Center(
          
          child: _weather == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Fetching weather...")
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(getWeatherAnimation(_weather!.mainCondition),
                    height: 150,
                    width: 150,
  fit: BoxFit.contain),
                      
                    Text(
                      _weather!.cityName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${_weather!.temperature.round()} °C",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      _weather!.mainCondition,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}