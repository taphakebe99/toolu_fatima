import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/shop/screens/home/widgets/home_categories.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/home/widgets/home_appbar.dart';
import '../search/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Header
                  const MyHomeAppBar(),
                  const SizedBox(height: MySizes.spaceBtwSections),

                  MySearchContainer(
                    text: 'Recherche...',
                    onTap: () => Get.to(() => SearchScreen()),
                  ),
                  const SizedBox(height: MySizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: HomeCategorySection(),
            ),
          ],
        ),
      ),
    );
  }
}
