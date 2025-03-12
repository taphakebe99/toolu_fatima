import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';


/// Controller for managing the onboarding screen navigation and page transitions.
class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Page controller for onboarding page view.
  final pageController = PageController();

  /// Observed variable to track the current page index.
  Rx<int> currentPageIndex = 0.obs;

  /// Updates `currentPageIndex` when the page scrolls.
  void updatePageIndicator(int index) => currentPageIndex.value = index;

  /// Navigates to a specific page based on dot indicator click.
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Advances to the next page. If on the last page, navigates to `LoginScreen`.
  void nextPage() {
    if (currentPageIndex.value == 1) {

      final storage = GetStorage();
      storage.write('IsFirstTime', false);

      // If on the last onboarding page, navigate to LoginScreen.
      Get.offAll(() => const LoginScreen());

    } else {
      // Otherwise, advance to the next page.
      int nextPageIndex = currentPageIndex.value + 1;
      pageController.jumpToPage(nextPageIndex);
    }
  }

  /// Skips directly to the last onboarding page.
  void skipPage() {
    currentPageIndex.value = 1;
    pageController.jumpToPage(1);
  }
}


