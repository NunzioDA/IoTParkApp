import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum ParkType {
  yellow,
  grey
}

class ParkWidget extends StatefulWidget{
  final double? width;
  final ParkType type;
  final bool occupied;
  final String parkId;
  final bool rightBorder;

  const ParkWidget({
    super.key,
    this.width,
    this.occupied = true,
    required this.type,
    required this.parkId,
    this.rightBorder = false,
  });

  @override
  State<ParkWidget> createState() => _ParkWidgetState();
}

class _ParkWidgetState extends State<ParkWidget> with SingleTickerProviderStateMixin{

  bool isOccupied = false;
  late AnimationController? _controller;
  late Animation<double> animation;
  int animationDirection = 1;

  @override
  void initState() {
    super.initState();
    isOccupied = widget.occupied;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 1, end: 0).animate(_controller!);
    _controller!.value = isOccupied ? 1 : 0;
    animationDirection = isOccupied ? 1 : -1;

    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant ParkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.occupied != isOccupied) {
      isOccupied = widget.occupied;
      if (isOccupied) {
        animationDirection = 1;
        _controller!.forward();
      } else {
        animationDirection = -1;
        _controller!.reverse();
      }
      // _controller!.value = 0;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        // border: Border(
        //   left: BorderSide(
        //     color: Colors.black,
        //     width: 1.5
        //   ),
        //   right: widget.rightBorder ? BorderSide(
        //     color: Colors.black,
        //     width: 1.5
        //   ) : BorderSide.none,
        // )
      ),
      child: AspectRatio(
        aspectRatio: 0.52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "#${widget.parkId}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w100,
                color: Colors.grey
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Positioned(
                          top: animation.value * -constraints.maxHeight * animationDirection + 20,
                          left: 0,   
                          right: 0,                     
                          child:
                            Image.asset(
                              widget.type == ParkType.grey ?
                              "assets/icons/grey-car.png" :
                              "assets/icons/yellow-car.png",
                              fit: BoxFit.cover,
                            ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: widget.occupied ? Colors.red : Colors.green,
                    shape: BoxShape.circle
                  ),
                ),
                const Gap(5),
                Text(
                  widget.occupied ? "Taken" : "Available",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey
                  ),
                )                
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}