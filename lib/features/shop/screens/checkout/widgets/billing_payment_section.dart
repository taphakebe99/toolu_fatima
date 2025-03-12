/*import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MyHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        MySectionHeading(
          title: 'Méthode de paiement',
          buttonTitle: const Text('Changer'),
          onPressed: () {},
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        Row(
          children: [
            MyRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: isDark ? MyColors.light : MyColors.white,
              child: const Image(
                  image: AssetImage(MyImages.wave), fit: BoxFit.contain),
            ),
            const SizedBox(height: MySizes.spaceBtwItems / 2),
            Text(
              'Wave',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ],
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/checkout_controller.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return Column(
      children: [
        MySectionHeading(
          title: 'Méthode de paiement',
          buttonTitle: const Text(''),
          //buttonTitle: const Text('Changer'),
          showActionButton: true,
          //onPressed: () {controller.selectPaymentMethod(context);
          onPressed: () => {},
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              MyRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: MyHelperFunctions.isDarkMode(context)
                    ? MyColors.light
                    : MyColors.white,
                padding: const EdgeInsets.all(MySizes.sm),
                child: Image(
                    image: AssetImage(
                        controller.selectedPaymentMethod.value.image),
                    fit: BoxFit.contain),
              ),
              const SizedBox(width: MySizes.spaceBtwItems / 2),
              Text(
                  controller.selectedPaymentMethod.value.name.capitalize
                      .toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
