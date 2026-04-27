import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';


class BackgroundSkin extends StatelessWidget {
  const BackgroundSkin({
    super.key,
    required this.image,
    required this.child,
  });
  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              const ColorFilter.mode(AppColors.grey500, BlendMode.darken),
          fit: BoxFit.cover,
          scale: 1.0,
          image: NetworkImage(
            image,
          ),
        ),
      ),
      child: child,
    );
  }
}