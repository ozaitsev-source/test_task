import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(border: Border()),
          child: Image.asset('assets/images/stars_sky_space.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
