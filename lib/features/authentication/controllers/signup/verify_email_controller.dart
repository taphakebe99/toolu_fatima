import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/succes_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    setTimerForAutoRedirect();
    sendEmailVerification();
    super.onInit();
  }

  void sendEmailVerification() async {
    await AuthenticationRepository.instance.sendEmailVerification();
    // Success SnackBar
    MyLoaders.successSnackBar(
      title: 'Email envoyé',
      message: 'Veuillez vérifier votre boîte mail.',
    );
    try {} catch (e) {
      MyLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            SuccessScreen(
              image: MyImages.successIllustration,
              title: MyTexts.yourAccountCreatedTitle,
              subTitle: MyTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance
                  .screenRedirect(FirebaseAuth.instance.currentUser),
            ),
          );
        }
      },
    );
  }

  void checkEmailVerificationStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        SuccessScreen(
          image: MyImages.successIllustration,
          title: MyTexts.yourAccountCreatedTitle,
          subTitle: MyTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance
              .screenRedirect(FirebaseAuth.instance.currentUser),
        ),
      );
    }
  }
}
