import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';

class ColorPickerPage extends StatefulWidget {
  final Color startColor;
  const ColorPickerPage({
    super.key,
    this.startColor = Colors.red,
  });

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late HSVColor color;

  @override
  void initState() {
    super.initState();
    color = HSVColor.fromColor(widget.startColor);
  }

  @override
  Widget build(BuildContext context) {

    double ringSize = 200;

    return Scaffold(
      backgroundColor: Colors.black.withAlpha(100),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
            Center(
              child: Container(
                height: ringSize + 115,
                width: ringSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(300),
                    topRight: Radius.circular(300),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30), 
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: ringSize,
                              width: ringSize,
                              child: ColorPickerHueRing(
                                color,
                                (newColor)=> setState(() {
                                  newColor = newColor.withSaturation(1);
                                  color = newColor;
                                }),
                                strokeWidth: 20,                    
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(50),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color.toColor(),                            
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Gap(30),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("White"),
                              const Gap(5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                width: 20,
                                height: 20,
                              )
                            ],
                          )
                        )
                      ),
                      const Gap(5),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(color.toColor()),
                          child: Text("Got it!")
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}

