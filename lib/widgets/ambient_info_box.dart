import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iot_park_app/UIUtilities/palette.dart';

class AmbientInfoBox extends StatelessWidget {
  const AmbientInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
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
                const Gap(10),
                Text(
                  "40°",
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
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
                const Gap(10),
                Text(
                  "30%",
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
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
                const Gap(10),
                Text(
                  "DARK",
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

}