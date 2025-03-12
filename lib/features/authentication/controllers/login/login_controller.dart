import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final hidePasswordLogin = true.obs;
  final hideConfirmPassword = true.obs;
  final confirmPassword = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      isLoading.value = true;
      MyFullScreenLoader.openLoadingDialog(
          'Chargement...', MyImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        MyLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        MyFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using EMail & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Assign user data to RxUser of UserController to use in app
      await userController.fetchUserRecord();

      // Remove Loader
      isLoading.value = false;
      MyFullScreenLoader.stopLoading();

      // Redirect
      await AuthenticationRepository.instance
          .screenRedirect(userCredentials.user);
    } catch (e) {
      MyFullScreenLoader.stopLoading();
      isLoading.value = false;

      MyLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> anonymousSignIn() async {
    try {
      isLoading.value = true;
      MyFullScreenLoader.openLoadingDialog(
          'Chargement...', MyImages.docerAnimation);

      // Vérification de la connexion internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyFullScreenLoader.stopLoading();
        MyLoaders.customToast(message: 'Pas de connexion internet');
        return;
      }

      // Connexion anonyme via Firebase
      final userCredential =
          await AuthenticationRepository.instance.signInAnonymously();

      await userController.fetchUserRecord();

      isLoading.value = false;
      MyFullScreenLoader.stopLoading();

      // Rediriger vers l'écran approprié
      await AuthenticationRepository.instance
          .screenRedirect(userCredential.user);
    } catch (e) {
      isLoading.value = false;
      MyFullScreenLoader.stopLoading();
      MyLoaders.errorSnackBar(title: 'Erreur', message: e.toString());
      throw "anonymousSignIn:  $e";
    }
  }

}

