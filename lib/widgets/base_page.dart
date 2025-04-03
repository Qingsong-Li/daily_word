import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  const BasePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(134, 177, 186, 1),
              Color.fromRGBO(121, 163, 171, 0),
            ],
            stops: [0.2038, 1.0],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
        child: 
        Column(
          children: [
            Expanded(child: child),
            SizedBox(height: 100.h,)
          ],
        ),
      ),
    );
  }
}
