// Classe de base pour les exceptions personnalisées
abstract class MyException implements Exception {
  String get message; // Chaque exception personnalisée doit fournir un message.
}
