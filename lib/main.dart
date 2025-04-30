import 'package:flutter/material.dart';
import 'battery_health_page.dart';

void main() {
  runApp(const MyBatteryApp());
}

class MyBatteryApp extends StatelessWidget {
  const MyBatteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BatteryHealthPage(),
    );
  }
}