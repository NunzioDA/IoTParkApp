import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iot_park_app/UIUtilities/park_widget.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top bar
              SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/icons/your-location.png",
                      height: 35,
                      width: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Location",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Urbino, Piazza della Repubblica, 13",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Gap(30),
              LayoutBuilder(
                builder: (context, costraints) {

                  int spacing = 10;

                  double parkWidth = (costraints.maxWidth - (spacing * 2)) / 3;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Second floor",),
                      const Gap(10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.yellow,
                          ),
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.grey,
                            occupied: false,
                          ),
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.yellow,
                          ),
                        ],
                      ),
                      const Gap(20),
                      Text("First floor",),
                      const Gap(10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.grey,
                          ),
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.yellow,
                          ),
                          ParkWidget(
                            width: parkWidth,
                            type: ParkType.grey,
                          ),
                        ],
                      ),
                  
                    ],
                  );
                }
              ),
              
            ],
          ),
        ),
      ),
    );
  }

}