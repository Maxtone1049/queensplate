import 'package:flutter/material.dart';


class OrderModel {
  final String orderId;
  final String date;
  final int itemsCount;
  final String amount;
  final String status;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.itemsCount,
    required this.amount,
    required this.status,
  });
}

// Add these models and variables
class TrackingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isCompleted;
  final bool isLast;

  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isCompleted = false,
    this.isLast = false,
  });
}