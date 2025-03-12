import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// The `MyHelperFunctions` class provides a set of common utility functions for color management, UI actions,
/// date formatting, and list manipulation, useful across various parts of a Flutter application.
class MyHelperFunctions {
  /// Returns a `Color` object corresponding to a given color [value] in string format.
  /// Defaults to white if the value does not match predefined colors.
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'Grey') {
      return Colors.grey;
    }
    return null;
  }

  /// Displays a `SnackBar` with the given [message] at the bottom of the screen.
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// Shows an alert dialog with the specified [title] and [message].
  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  /// Navigates to the specified [screen] within the provided [context].
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Truncates the [text] to a maximum length of [maxLength] characters,
  /// adding "..." at the end if truncation is needed.
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  /// Checks if the device is in dark mode by evaluating the current theme.
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Retrieves the size of the device screen using `Get.context`.
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  /// Returns the height of the screen.
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  /// Returns the width of the screen.
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  /// Formats the given [date] to the specified [format].
  /// Defaults to 'dd MMM yyyy' if no format is provided.
  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  /// Removes duplicate entries from a list [list] and returns a new list with unique elements.
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Wraps a list of [widgets] into rows, each containing up to [rowSize] widgets.
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }
}
