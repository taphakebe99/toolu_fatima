import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/my_circular_image.dart';

class MyUserProfileTile extends StatelessWidget {
  const MyUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const MyCircularImage(
        image: MyImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: MyColors.black),
      ),
      subtitle: Text(
        controller.user.value.phoneNumber,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: MyColors.darkerGrey),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: MyColors.black,
        ),
      ),
    );
  }
}
