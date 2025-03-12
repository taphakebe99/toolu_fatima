import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../../personalization/models/user_model.dart';
import '../../../shop/screens/checkout/checkout.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final privacyPolicy = false.obs;
  var isFormValid = false.obs;
  final isLoading = false.obs;

  final email = TextEditingController();
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;
  final completeProfileFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Start loading
      isLoading.value = true;

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.openLoadingDialog(
          'Chargement...',
          MyImages.successIllustration,
        );
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        isLoading.value = false;
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Passwords match check
      if (password.text != confirmPassword.text) {
        Get.snackbar("Erreur", "Les mots de passe ne correspondent pas!");
        isLoading.value = false;
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        MyLoaders.warningSnackBar(
          title: MyTexts.acceptPrivacyPolicy,
          message: MyTexts.acceptPrivacyPolicyMessage,
        );
        isLoading.value = false;
        return;
      }

      // Validate email format
      if (!GetUtils.isEmail(email.text.trim())) {
        Get.snackbar("Erreur", "L'email fourni est invalide.");
        isLoading.value = false;
        return;
      }

      // Check if the user is anonymous
      final user = _authRepo.firebaseUser;
      if (user != null && user.isAnonymous) {
        // User is anonymous, link the account with email and password
        final credential = EmailAuthProvider.credential(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        // Link the anonymous account with the new credentials
        await user.linkWithCredential(credential);
        await _completeSignupProcess(user);
      } else {
        // Authenticate with email and password
        final userCredential = await _authRepo.registerWithEmailAndPassword(
          email.text.trim(),
          password.text.trim(),
        );

        await _completeSignupProcess(userCredential.user);
      }

      // Stop loading
      isLoading.value = false;

      // Success SnackBar
      MyLoaders.successSnackBar(
        title: 'Succès',
        message: 'Votre compte a été créé avec succès.',
      );

      // Navigate to verify email screen
      Get.to(
        () => VerifyEmailScreen(email: email.text.trim()),
      );
    } catch (e) {
      isLoading.value = false;
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Helper method to handle user creation or update after linking account
  Future<void> _completeSignupProcess(User? user) async {
    if (user == null) return;

    // Create a user model
    final newUser = UserModel(
      id: user.uid,
      fullName: fullName.text.trim(),
      email: email.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: '',
    );

    // Save user to Firestore
    final userRepo = Get.put(UserRepository());
    await userRepo.saveUserRecord(newUser);

    await UserController.instance.fetchUserRecord();
  }

  void updateFormState() {
    isFormValid.value =
        completeProfileFormKey.currentState?.validate() ?? false;
  }

  void validateAndProceed() {
    if (!isFormValid.value) {
      MyLoaders.warningSnackBar(
        title: 'Champs obligatoires',
        message: 'Veuillez remplir tous les champs avant de continuer.',
      );

      return;
    }
    if (!privacyPolicy.value) {
      MyLoaders.warningSnackBar(
        title: MyTexts.acceptPrivacyPolicy,
        message: MyTexts.acceptPrivacyPolicyMessage,
      );
      return;
    }

    updateUserProfile();
  }

  void updateUserProfile() async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.openLoadingDialog(
            'Chargement...', MyImages.successIllustration);
        return;
      }

      if (!completeProfileFormKey.currentState!.validate()) {
        isLoading.value = false;
        MyFullScreenLoader.stopLoading();
        return;
      }

      final newUser = UserModel(
        id: _authRepo.getUserID,
        fullName: fullName.text.trim(),
        phoneNumber: phoneNumber.text.trim().toString(),
        profilePicture: '',
        email: '',
      );

      final userRepo = Get.put(UserRepository());
      await userRepo.saveUserRecord(newUser);

      await UserController.instance.fetchUserRecord();

      isLoading.value = false;
      MyFullScreenLoader.stopLoading();

      MyLoaders.successSnackBar(
        title: 'Succès',
        message: 'Votre profil a été mis à jour avec succès.',
      );

      Get.to(() => const CheckoutScreen());
    } catch (e) {
      isLoading.value = false;
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

