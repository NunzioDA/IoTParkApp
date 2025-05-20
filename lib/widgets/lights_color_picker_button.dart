import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iot_park_app/smartpark.dart';
import 'package:iot_park_app/pages/color_picker_page.dart';

class LightsColorPickerButton extends StatelessWidget{
  final void Function(Color color) onColorSelected;
  const LightsColorPickerButton({
    super.key,
    required this.onColorSelected,
  });

  Future<Color?> showColorPickerPage(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
          ColorPickerPage(
            startColor: SmartPark.lightColor,
          ),
        opaque: false,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()async{
        Color? color = await showColorPickerPage(context);
        if (color != null) {
          onColorSelected(color);
        }
      },
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Image.asset("assets/icons/color-circle.png"),
            ),
            const Gap(10),
            Text("Change color"),
          ],
        )
      ),
    );
  }
  
}