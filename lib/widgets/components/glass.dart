import 'dart:ui';

import 'package:flutter/material.dart';

class CustomGlass extends StatelessWidget {
  final double height, width;
  final Color color;
  final Widget child;
  const CustomGlass({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
          height: height,
          width: width,
          color: color,
          child: Stack(
            children: [
              // blur effect
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Container(),
              ),

              //gradient effect
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1)
                    ],
                  ),
                ),
              ),

              //child
              child,
            ],
          )),
    );
  }
}
