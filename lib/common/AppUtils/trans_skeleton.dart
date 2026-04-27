import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:shimmer/shimmer.dart';


import '../../../../Common/Gap.dart';

class TransactionSkeleton extends StatelessWidget {
  const TransactionSkeleton({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.grey400,
                      highlightColor: AppColors.grey200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.red,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 40.h,
                        padding: const EdgeInsets.all(23),
                      ),
                    ),
                    const Gap(height: 4),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.red,
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        height: 35.h,
                        padding: const EdgeInsets.all(23),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
