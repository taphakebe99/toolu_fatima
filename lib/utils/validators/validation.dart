
/// A utility class for validating user input fields such as email, password, and phone number.
class MyValidator {



  /// Validates an email address.
  ///
  /// Returns an error message if the email is invalid,
  /// or null if the email is valid.
  static String? validateEmail(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'L\'email est requis'; // Return error message if email is required
    }

    // Regular expression to validate email format
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regular expression
    if (!emailRegExp.hasMatch(value)) {
      return 'Adresse email invalide.'; // Return error message if email is invalid
    }

    return null; // Return null if email is valid
  }

  /// Validates a password.
  ///
  /// Returns an error message if the password does not meet criteria,
  /// or null if the password is valid.
  static String? validatePassword(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis'; // Return error message if password is required
    }


    // Check if password length is at least 6 characters
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères.'; // Return error for length
    }

    // Check if password contains at least one uppercase letter
    /*if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une lettre majuscule'; // Error for uppercase letter
    }

    // Check if password contains at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre'; // Error for digit
    }

    // Check if password contains at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Le mot de passe doit contenir au moins un caractère spécial'; // Error for special character
    }*/

    return null; // Return null if password is valid
  }

  /// Validates a phone number.
  ///
  /// Returns an error message if the phone number is invalid,
  /// or null if the phone number is valid.
  static String? validatePhoneNumber(String? value) {

    // Vérifie si la valeur est null ou vide
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis'; // Retourne un message d'erreur si le numéro est requis
    }

    // Expression régulière pour valider les numéros au format E.164


    return null; // Retourne null si le numéro de téléphone est valide
  }



  /// Validate empty text
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

}
