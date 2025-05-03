import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iot_park_app/UIUtilities/palette.dart';
import 'package:iot_park_app/communication.dart';

class AmbientInfoBox extends StatelessWidget {
  const AmbientInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Palette.infoBoxes,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "assets/icons/temperature.png"
                  ),
                ),
                const Gap(5),
                Text(
                  SmartPark.temperature,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Palette.infoBoxes,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "assets/icons/drop.png"
                  ),
                ),
                const Gap(5),
                Text(
                  SmartPark.humidity,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Palette.infoBoxes,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "assets/icons/sun.png"
                  ),
                ),
                const Gap(5),
                Text(
                  SmartPark.light,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Palette.infoBoxes,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    "assets/icons/wind-sign.png"
                  ),
                ),
                const Gap(5),
                Text(
                  SmartPark.airQuality,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

}