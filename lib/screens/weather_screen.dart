import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weatherData = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Los permisos de ubicación están denegados permanentemente.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final position = await _getCurrentLocation();
      final url = Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];
        setState(() {
          _weatherData =
              'Clima actual: ${currentWeather['temperature']}°C, ${currentWeather['weathercode']}';
        });
      } else {
        setState(() {
          _weatherData = 'Mensaje: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _weatherData = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App del clima")),
      body: Center(child: Text(_weatherData)),
    );
  }
}
