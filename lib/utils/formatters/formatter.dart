import 'package:intl/intl.dart';

/// The `MyFormatter` class provides utility methods for formatting dates,
/// currency values, and phone numbers in different formats.
class MyFormatter {
  /// Formats a given [date] as a string in the `dd-MMM-yyyy` format.
  /// If no date is provided, it defaults to the current date.
  ///
  /// Example: `01-Jan-2023`
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  /// Formats a given [amount] as a currency string in US dollar format
  /// with the dollar sign symbol (`$`) and appropriate commas.
  ///
  /// Example: `$1,234.00`
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_XOF', symbol: 'FCA').format(amount);
  }

  /// Formats a given US [phoneNumber] as a string in the format `(123) 456-7890`
  /// for a 10-digit number or `(1234) 567-890` for an 11-digit number.
  /// If the length of the phone number is neither 10 nor 11, the original number is returned.
  ///
  /// Example: `(123) 456-7890` or `(1234) 567-890`
  static String formatPhoneNumber(String phoneNumber) {
    // Checks if the number has 10 digits
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    }
    // Checks if the number has 11 digits
    else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  /// Formats an international [phoneNumber] with country code.
  /// Extracts the country code from the first two digits and separates
  /// the remaining digits into groups of 2 for readability. If the
  /// country code is `+1` (US), the first group is 3 digits.
  ///
  /// Example: `+33` code results in `(+33) 12 34 56 78`
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-numeric characters
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Create a formatted number with the country code
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;

      // If the country code is `+1` (US), the first group has 3 digits
      if (countryCode == '+1' && i == 0) {
        groupLength = 3;
      }

      int end = i + groupLength;
      if (end > digitsOnly.length) end = digitsOnly.length;

      formattedNumber.write(digitsOnly.substring(i, end));

      // Add a space between groups if there are more digits remaining
      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    // Return the formatted international phone number
    return formattedNumber.toString();
  }
}
