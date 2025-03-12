import 'exception.dart';

class MyFirebaseAuthException implements MyException {
  final String code;

  MyFirebaseAuthException(this.code);

  @override
  String get message {
    switch (code) {
      case 'invalid-email':
        return 'Adresse e-mail invalide. Veuillez vérifier et réessayer.';
      case 'user-disabled':
        return 'Ce compte a été désactivé. Veuillez contacter le support.';
      case 'user-not-found':
        return 'Utilisateur introuvable. Vérifiez vos informations ou inscrivez-vous.';
      case 'wrong-password':
        return 'Mot de passe incorrect. Veuillez réessayer.';
      case 'email-already-in-use':
        return 'Cette adresse e-mail est déjà utilisée. Veuillez utiliser une autre adresse.';
      case 'weak-password':
        return 'Le mot de passe est trop faible. Veuillez choisir un mot de passe plus fort.';
      case 'operation-not-allowed':
        return 'Cette opération n\'est pas autorisée. Veuillez contacter le support.';
      case 'account-exists-with-different-credential':
        return 'Un compte existe déjà avec une autre méthode d\'authentification.';
      case 'invalid-credential':
        return 'Les informations d\'identification sont invalides ou expirées.';
      case 'requires-recent-login':
        return 'Cette action nécessite une connexion récente. Veuillez vous reconnecter.';
      default:
        return 'Une erreur d\'authentification inattendue est survenue. Code d\'erreur : $code.';
    }
  }
}
