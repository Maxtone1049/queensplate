import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';

// Quantity Button Widget
class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 22, color: AppColors.yellow500),
    );
  }
}
