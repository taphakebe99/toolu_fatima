import 'exception.dart';

class MyPlatformException implements MyException {
  final String code;

  MyPlatformException(this.code);

  @override
  String get message {
    switch (code) {
      case 'network_error':
        return 'Erreur réseau. Veuillez vérifier votre connexion.';
      case 'permission_denied':
        return 'Permission refusée. L\'application n\'a pas les autorisations nécessaires.';
      case 'not_implemented':
        return 'Cette fonctionnalité n\'est pas encore disponible sur cette plateforme.';
      case 'platform_unavailable':
        return 'La plateforme est actuellement indisponible. Veuillez réessayer plus tard.';
      default:
        return 'Une erreur de la plateforme est survenue. Code d\'erreur : $code.';
    }
  }
}
