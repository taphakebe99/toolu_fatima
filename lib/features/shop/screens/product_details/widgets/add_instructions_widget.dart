import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controllers/product/cart_controller.dart';

class AddInstruction extends StatelessWidget {
  const AddInstruction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Form(
      child: TextFormField(
        controller: controller.instruction,
        decoration: InputDecoration(
          labelText: 'Instruction',
          hintText: 'Ajoutez des instructions ou des préférences',
          hintStyle: TextStyle(
            color: MyColors.grey,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
