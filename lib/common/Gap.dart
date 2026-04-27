import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const Gap({this.height, this.width, Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: height?.h, width: width?.w, child: child);
}
