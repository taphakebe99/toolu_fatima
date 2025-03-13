import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/shop/screens/orders/widgets/order_tab.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/order_controller.dart';
import '../../models/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MyHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: MyAppBar(
          showBackArrow: true,
          title: Text(
            'Mes commandes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.sm),
              child: MyCartCounterIcon(),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrollable) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: isDarkMode ? MyColors.black : MyColors.white,
                expandedHeight: 80,
                // Onglets
                bottom: const MyTabBar(
                  tabs: [
                    Tab(child: Text('En cours')),
                    Tab(child: Text('Livrée')),
                    Tab(child: Text('Annulée')),
                  ],
                ),
              ),
            ];
          },
          body: FutureBuilder<List<OrderModel>>(
            future: controller.fetchUserOrders(),
            builder: (context, snapshot) {
              /// Helper Function: Handle Loader, No Record, OR ERROR Message
              final response = MyCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: const MyVerticalProductShimmer());
              if (response != null) return response;

              // Une fois les commandes récupérées
              final orders = snapshot.data!;
              // Filtrage par statut (adapté selon vos propriétés)
              final ordersEnCours = orders
                  .where((order) =>
                      order.status == OrderStatus.pending ||
                      order.status == OrderStatus.processing)
                  .toList();
              final ordersLivrees = orders
                  .where((order) => order.status == OrderStatus.delivered)
                  .toList();
              final ordersAnnulees = orders
                  .where((order) => order.status == OrderStatus.cancelled)
                  .toList();

              return TabBarView(
                children: [
                  MyOrderTab(orders: ordersEnCours),
                  MyOrderTab(orders: ordersLivrees),
                  MyOrderTab(orders: ordersAnnulees),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
