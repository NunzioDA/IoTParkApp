import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum ParkType {
  yellow,
  grey
}

class ParkWidget extends StatelessWidget{
  final double? width;
  final ParkType type;
  final bool occupied;

  const ParkWidget({
    super.key,
    this.width,
    this.occupied = true,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AspectRatio(
        aspectRatio: 0.52,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              occupied ?
                Image.asset(
                  type == ParkType.grey ?
                  "assets/icons/grey-car.png" :
                  "assets/icons/yellow-car.png",
                  fit: BoxFit.cover,
                ):
                SizedBox(
                  height: 50,
                ),
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: occupied ? Colors.red : Colors.green,
                      shape: BoxShape.circle
                    ),
                  ),
                  const Gap(5),
                  Text(
                    occupied ? "Occupied" : "Available",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}