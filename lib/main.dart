import 'package:deep_wheatherapp/providers/weather_provider.dart';
import 'package:deep_wheatherapp/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherScreen(),
      title: "App del clima",
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
