import 'package:deep_wheatherapp/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    weatherProvider.fetchWeatherData();

    return Scaffold(
      appBar: AppBar(title: Text("App del clima")),
      body: Center(child: Text(weatherProvider.weatherData)),
    );
  }
}
