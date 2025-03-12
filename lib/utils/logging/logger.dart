import 'package:logger/logger.dart';

/// A helper class for logging messages with different severity levels.
/// This class uses the `Logger` package to output formatted log messages
/// with methods for various log levels, making it easy to manage log messages.
class MyLoggerHelper {
  // A private `Logger` instance with custom settings.
  // Configured with a `PrettyPrinter` to format logs in an easy-to-read format.
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug, // Set the default log level to debug.
  );

  /// Logs a debug message.
  /// This is intended for detailed development/debugging information.
  static void debug(String message) {
    _logger.d(message);
  }

  /// Logs an informational message.
  /// Use this for general information that may be helpful during operation.
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message.
  /// Useful for indicating potential issues or unusual events in the application.
  static void warning(String message) {
    _logger.w(message);
  }

  /// Logs an error message with optional error details.
  /// Use this for exceptions or serious errors. Optionally pass in an error object for detailed error information.
  /// Includes a stack trace to aid in debugging.
  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}
