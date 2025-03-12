// Exception pour FormatException
import 'exception.dart';

class MyFormatException implements MyException {
  @override
  String get message => 'Format invalide. Veuillez vérifier vos entrées.';
}
