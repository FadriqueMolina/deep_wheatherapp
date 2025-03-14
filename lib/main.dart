import 'package:deep_wheatherapp/screens/weather_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
      title: "App del clima",
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
