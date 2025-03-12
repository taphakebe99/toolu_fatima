import 'exception.dart';

class MyGeneralException implements MyException {
  @override
  String get message => 'Une erreur est survenue. Veuillez réessayer.';
}
