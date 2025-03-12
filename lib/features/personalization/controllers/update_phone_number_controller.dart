import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toolu_fatima/features/personalization/controllers/user_controller.dart';

import '../../../data/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/user_model.dart';
import '../screens/profile/profile.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();
  final isLoading = false.obs;
  final phoneNumber = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final userController = Get.put(UserController());
  GlobalKey<FormState> updateUserPhoneNumberFormKey = GlobalKey<FormState>();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  Future<void> initializePhoneNumber() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updateUserPhoneNumber() async {
    try {
      // Start loading
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.openLoadingDialog(
            'Chargement...', MyImages.successIllustration);

        return;
      }

      // Form validation
      if (!updateUserPhoneNumberFormKey.currentState!.validate()) {
        MyFullScreenLoader.openLoadingDialog(
            'Chargement...', MyImages.successIllustration);
        return;
      }

      // update user's full name
      Map<String, dynamic> phone = {'PhoneNumber': phoneNumber.text.trim()};
      await userRepository.updateSingleField(phone);

      // update the Rx User value
      userController.user.value.phoneNumber = phoneNumber.text.trim();
      Get.appUpdate();

      // remove loader
      isLoading.value = false;

      // show success message
      MyLoaders.successSnackBar(
        title: 'Succès',
        message: 'Votre numéro a été modifié avec succès.',
      );

      // move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      isLoading.value = false;
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
