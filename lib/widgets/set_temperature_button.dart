import 'package:flutter/material.dart';
import 'package:iot_park_app/communication.dart';
import 'package:iot_park_app/pages/temperature_set_page.dart';

class SetTemperatureButton extends StatelessWidget{
  const SetTemperatureButton({super.key});

  Future<int?> pickTargetTemperature(BuildContext context) async {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
          TemperatureSetPage(
            startTemperature: SmartPark.targetTemperature,
          ),
        opaque: false,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        int? targetTemperature = await pickTargetTemperature(context);
        if (targetTemperature != null) SmartPark.setTemperature(targetTemperature);
      },
      child: const Text('Set Temperature'),
    );
  }

}