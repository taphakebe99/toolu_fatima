import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../home_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../search/search.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key, required this.title, required this.parentId});

  final String title;
  final String parentId;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    final categories = categoryController.allCategories
        .where((category) =>
            (category.parentId != '') && (category.parentId == parentId))
        .toList();

    final dark = MyHelperFunctions.isDarkMode(context);
    return PopScope(
      canPop: false,
      // Intercepte l'appui sur le bouton retour et redirige vers l'écran d'accueil
      onPopInvokedWithResult: (_, value) async {
        // Retarder l'appel à la navigation après le rendu du frame actuel
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => const HomeMenu());
        });
      },
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: MyAppBar(
            showBackArrow: true,
            title:
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
            actions: const [MyCartCounterIcon()],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  // Espace entre l'AppBar et le TabBar. Dans cette hauteur, nous avons ajouté la barre de recherche et les marques en vedette.
                  expandedHeight: 180,
                  automaticallyImplyLeading: false,
                  backgroundColor: dark ? MyColors.black : MyColors.white,

                  /// -- Recherche & Store en vedette
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(MySizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// -- Barre de recherche
                        const SizedBox(height: MySizes.spaceBtwItems),
                        MySearchContainer(
                          text: 'Recherche...',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                          onTap: () => Get.to(() => SearchScreen()),
                        ),
                        const SizedBox(height: MySizes.spaceBtwSections),
                      ],
                    ),
                  ),

                  /// -- TABS
                  bottom: MyTabBar(
                    tabs: categories
                        .map((e) => Tab(child: Text(e.name)))
                        .toList(),
                  ),
                )
              ];
            },

            /// -- Contenu des vues du TabBar
            body: TabBarView(
              children: categories
                  .map((category) => MyCategoryTab(category: category))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
