import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../shop/screens/home/home.dart';
import '../login/login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(MySizes.defaultSpace),
        child: Column(
          children: [
            /// Image
            Image(
              image: const AssetImage(MyImages.deliveredEmailIllustration),
              width: MyHelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            /// Title & SubTitle
            ///
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            Text(
              email,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MySizes.spaceBtwItems),
            Text(
              MyTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.offAll(() => LoginScreen()),
                child: const Text(MyTexts.done),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => const HomeScreen(),
                child: const Text(MyTexts.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordController {}
