import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider extends ChangeNotifier {
  String weatherData = "Cargando...";

  Future<void> fetchWeatherData() async {
    try {
      final position = await _getCurrentLocation();
      final url = Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current_weather=true",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];
        weatherData =
            'Clima actual: ${currentWeather['temperature']}°C, ${currentWeather['weathercode']}';
      } else {
        weatherData = 'Mensaje: ${response.body}';
      }
    } catch (e) {
      weatherData = 'Error: $e';
    } finally {
      notifyListeners();
    }
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
}
