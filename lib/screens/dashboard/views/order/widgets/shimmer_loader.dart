import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/common/Gap.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 4,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: RepaintBoundary(child: _ShimmerOrderCard()),
      ),
    );
  }
}

class _ShimmerOrderCard extends StatefulWidget {
  const _ShimmerOrderCard();

  @override
  State<_ShimmerOrderCard> createState() => _ShimmerOrderCardState();
}

class _ShimmerOrderCardState extends State<_ShimmerOrderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerLine(140.w, 18.h),
              Gap(height: 12.h),
              _shimmerLine(190.w, 12.h),
              Gap(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _shimmerLine(110.w, 28.h),
                  _shimmerLine(95.w, 34.h, radius: 20.r),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _shimmerLine(double width, double height, {double radius = 8}) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: const [
            Color(0xFFF0F0F0),
            Color(0xFFE8E8E8),
            Color(0xFFF0F0F0),
          ],
          stops: [0.0, _controller.value, 1.0],
        ).createShader(bounds);
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
