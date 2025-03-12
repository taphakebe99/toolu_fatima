import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/signup/signup_controller.dart';

class MyTermsAndConditionCheckbox extends StatelessWidget {
  const MyTermsAndConditionCheckbox({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController()); //SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(height: MySizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${MyTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${MyTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: isDarkMode ? MyColors.white : MyColors.primary,
                        decorationColor:
                            isDarkMode ? MyColors.white : MyColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
                TextSpan(
                  text: '${MyTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: MyTexts.termsofUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: isDarkMode ? MyColors.white : MyColors.primary,
                        decorationColor:
                            isDarkMode ? MyColors.white : MyColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
