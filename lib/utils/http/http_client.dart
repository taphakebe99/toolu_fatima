import 'dart:convert';
import 'package:http/http.dart' as http;

/// A helper class for making HTTP requests to a specified base URL.
class MyHttpClient {
  // The base URL for API requests.
  static const String _baseUrl = 'https://my-api-base-url.com';

  /// Sends a GET request to the specified [endpoint] and returns the response as a JSON map.
  static Future<Map<String, dynamic>> get(String endpoint) async {
    // Construct the full URL and send a GET request.
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  /// Sends a POST request with JSON [data] to the specified [endpoint]
  /// and returns the response as a JSON map.
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    // Construct the full URL, set headers, and send a POST request with JSON-encoded data.
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Sends a PUT request with JSON [data] to the specified [endpoint]
  /// and returns the response as a JSON map.
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    // Construct the full URL, set headers, and send a PUT request with JSON-encoded data.
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Sends a DELETE request to the specified [endpoint] and returns the response as a JSON map.
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    // Construct the full URL and send a DELETE request.
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  /// A helper function to handle HTTP responses.
  /// If the status code is 200, it decodes and returns the JSON response body.
  /// Otherwise, it throws an exception with the status code.
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      // Decode the response body and return it as a JSON map.
      return json.decode(response.body);
    }
    // Throw an exception if the request was unsuccessful.
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
