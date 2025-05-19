import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iot_park_app/UIUtilities/palette.dart';
import 'package:iot_park_app/communication.dart';
import 'package:iot_park_app/widgets/ambient_info_box.dart';
import 'package:iot_park_app/widgets/lights_color_picker_button.dart';
import 'package:iot_park_app/widgets/park_widget.dart';
import 'package:iot_park_app/widgets/set_temperature_button.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late Timer _timer;
  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   SmartPark.getStatus().then((value) {
    //     if(value) {
    //       setState(() {});
    //     }
    //   });
    // });
    SmartPark.init((state) {
      if(mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // _timer.cancel();
    SmartPark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top bar
                Column(           
                  crossAxisAlignment: CrossAxisAlignment.center,         
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: 20
                        ),
                        const Gap(10),
                        Text(
                          "Urbino, PU",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2
                          ),                    
                        ),
                      ],
                    ),
                    Text(
                      "Piazza della Repubblica, 13",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 1.2
                      ),                                
                    ),
                  ],
                ),
                const Gap(25),
                AmbientInfoBox(),
                const Gap(25),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: LayoutBuilder(
                    builder: (context, costraints) {
                  
                      int spacing = 0;
                  
                      double parkWidth = (costraints.maxWidth - (spacing * 2) - 20) / 3;
                  
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Parking Lots",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  occupied: SmartPark.parkTaken[0],
                                  parkId: "A1"
                                ),
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  occupied: SmartPark.parkTaken[1],
                                  parkId: "A2"
                                ),
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  parkId: "A3",
                                  occupied: SmartPark.parkTaken[2],
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  occupied: SmartPark.parkTaken[3],
                                  parkId: "B1"
                                ),
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  occupied: SmartPark.parkTaken[4],
                                  parkId: "B2"
                                ),
                                ParkWidget(
                                  width: parkWidth,
                                  type: ParkType.grey,
                                  parkId: "B3",
                                  occupied: SmartPark.parkTaken[5],
                                ),
                              ],
                            ),
                          ),                      
                        ],
                      );
                    }
                  ),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lights",
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                      const Gap(5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            LightsColorPickerButton(
                              onColorSelected: (color) {
                                SmartPark.lightsColor(color);
                              },
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.lightsOn, 
                                    child: Text("On")
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.lightsOff, 
                                    child: Text("Off")
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.lightsAuto, 
                                    child: Text("Auto")
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Air Conditioning",
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                      const Gap(5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SetTemperatureButton(),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.setAirConditioningHot, 
                                    child: Text("Warm")
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.setAirConditioningCool, 
                                    child: Text("Cool")
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: SmartPark.airConditioningOff, 
                                    child: Text("Off")
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}