import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/app_colors.dart';
import '../TextView/Models/TextViewConfig.dart';
import '../TextView/TextView.dart';
import 'Model/TabModel.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onTap,
  });

  final List<TabModel> tabs;
  final TabModel selectedTab;
  final Function(TabModel) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            tabs
                .map(
                  (tab) => Flexible(
                    child: InkWell(
                      onTap: () async {
                        await HapticFeedback.mediumImpact();
                        onTap(tab);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: tab.key == selectedTab.key ? null : 0,
                          color:
                              tab.key == selectedTab.key
                                  ? null
                                  : AppColors.grey50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Padding(
                            padding:
                                tab.key == selectedTab.key
                                    ? EdgeInsets.symmetric(
                                      horizontal: 12.r,
                                      vertical: 8.r,
                                    )
                                    : EdgeInsets.symmetric(
                                      horizontal: 24.r,
                                      vertical: 8.r,
                                    ),
                            child: TextView(
                              config: TextViewConfig(
                                text: tab.value,
                                textAlign: TextAlign.center,
                                textStyle: Theme.of(
                                  context,
                                ).textTheme.headlineMedium?.copyWith(
                                  fontSize: 14.sp,
                                  color:
                                      tab.key != selectedTab.key
                                          ? AppColors.grey500
                                          : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
