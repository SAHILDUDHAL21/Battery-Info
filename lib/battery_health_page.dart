import 'package:flutter/material.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';

class BatteryHealthPage extends StatefulWidget {
  const BatteryHealthPage({super.key});

  @override
  State<BatteryHealthPage> createState() => _BatteryHealthPageState();
}

class _BatteryHealthPageState extends State<BatteryHealthPage> {
  AndroidBatteryInfo? _batteryInfo;

  @override
  void initState() {
    super.initState();
    fetchBatteryInfo();
  }

  Future<void> fetchBatteryInfo() async {
    try {
      final info = await BatteryInfoPlugin().androidBatteryInfo;
      if (info != null) {
        setState(() {
          _batteryInfo = info;
        });
      } else {
        print('Battery info is null');
      }
    } catch (e) {
      print('Error fetching battery info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Info')),
      body:
          _batteryInfo == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  infoTile('Battery Level', '${_batteryInfo!.batteryLevel}%'),
                  infoTile('Health', _batteryInfo!.health ?? 'Unknown'),
                  infoTile('Voltage', '${_batteryInfo!.voltage} mV'),
                  infoTile('Temperature', '${_batteryInfo!.temperature} °C'),
                  infoTile(
                    'Charging Status',
                    _batteryInfo!.chargingStatus?.toString() ?? 'Unknown',
                  ),
                  infoTile('Technology', _batteryInfo!.technology ?? 'Unknown'),
                  infoTile('Capacity', '${_batteryInfo!.batteryCapacity} mAh'),
                ],
              ),
    );
  }

  Widget infoTile(String title, String value) {
    return ListTile(title: Text(title), trailing: Text(value));
  }
}
