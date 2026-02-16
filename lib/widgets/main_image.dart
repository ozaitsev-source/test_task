import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border()),
        child: Image.asset('assets/images/stars_sky_space.jpg', fit: BoxFit.fitHeight),
      ),
    );
  }
}
