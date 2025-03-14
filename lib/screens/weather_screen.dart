import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(
      context,
      listen: false,
    );
    final future = weatherProvider.fetchWeatherData();

    return Scaffold(
      appBar: AppBar(title: const Text('App del Clima')),
      body: FutureBuilder<void>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return Center(
                  child: Text(
                    weatherProvider.weatherData,
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
