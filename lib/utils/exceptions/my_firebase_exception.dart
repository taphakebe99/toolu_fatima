import 'exception.dart';

class MyFirebaseException implements MyException {
  final String code;

  MyFirebaseException(this.code);

  @override
  String get message {
    switch (code) {
      case 'permission-denied':
        return 'Permission refusée. Vous n\'avez pas les droits nécessaires pour effectuer cette action.';
      case 'unavailable':
        return 'Service indisponible. Veuillez réessayer plus tard.';
      case 'network-error':
        return 'Erreur réseau. Impossible de communiquer avec le serveur.';
      case 'aborted':
        return 'Opération interrompue. Veuillez réessayer.';
      case 'already-exists':
        return 'L\'élément que vous essayez de créer existe déjà.';
      case 'cancelled':
        return 'Opération annulée.';
      case 'data-loss':
        return 'Perte de données détectée. Veuillez vérifier votre entrée ou réessayer.';
      case 'deadline-exceeded':
        return 'Temps d\'attente dépassé. Le serveur a mis trop de temps à répondre.';
      case 'internal':
        return 'Erreur interne du serveur. Veuillez réessayer plus tard.';
      case 'invalid-argument':
        return 'Argument invalide fourni. Vérifiez les informations saisies.';
      case 'not-found':
        return 'Élément non trouvé. Assurez-vous que les informations sont correctes.';
      case 'out-of-range':
        return 'Valeur hors des limites autorisées.';
      case 'resource-exhausted':
        return 'Les ressources sont épuisées. Veuillez attendre un moment avant de réessayer.';
      case 'unauthenticated':
        return 'Vous devez être connecté pour effectuer cette action.';
      case 'failed-precondition':
        return 'Précondition échouée. Assurez-vous que toutes les conditions nécessaires sont remplies.';
      case 'unknown':
        return 'Erreur inconnue. Veuillez réessayer ou contacter le support.';
      default:
        return 'Une erreur Firebase inattendue est survenue. Code d\'erreur : $code.';
    }
  }
}
