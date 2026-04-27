import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/order_widgets.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/shimmer_loader.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  Future<void> _refreshOrders(CartViewModel model) async {
    await model.fetchOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      onViewModelReady: (model) =>
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await model.fetchOrderHistory();
          }),
      disposeViewModel: false,
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            childPadding: EdgeInsets.zero,
            child: RefreshIndicator(
              onRefresh: () => _refreshOrders(model),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Header (non‑scrollable part)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              TextView(
                                config: TextViewConfig(
                                  text: "Order History",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Gap(height: 20),
                      ],
                    ),
                  ),
                  // Content (orders or empty state)
                  if (model.isBusy)
                    const SliverFillRemaining(
                      child: Center(child: ShimmerLoader()),
                    )
                  else if ((model.orderHistory?.data?.orders ?? []).isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: Text("No orders yet")),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final order = model.orderHistory!.data!.orders[index];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16.w) +
                              EdgeInsets.only(bottom: 16.h),
                          child: InkWell(
                            onTap: () => PageRouter.pushNamed(
                              Routes.orderTrackingView,
                              args: OrderTrackingViewArguments(
                                orderId: order.orderNumber.toString(),
                                orderInfo: order,
                              ),
                            ),
                            child: buildOrderCard(order, model,(){}),
                          ),
                        );
                      }, childCount: model.orderHistory!.data!.orders.length),
                    ),
                  // Optional bottom spacing
                  SliverToBoxAdapter(child: Gap(height: 20.h)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
