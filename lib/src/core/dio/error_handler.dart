import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class ErrorHandler {
  static String getErrorMsg(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.badCertificate ||
        error.type == DioExceptionType.cancel) {
      return dioExceptionHandler(error);
    }
    if (error.response == null || error.response!.statusCode == null) {
      return 'Unexpected error';
    }
    final response = error.response!.data;
    try {
      if (response is Map<String, dynamic>) {
        // Case 1: {"message": "..."}
        if (response['message'] != null) {
          return response['message'].toString();
        }
        if (response['errors'] != null) {
          return response['errors'].toString();
        }

        // Case 3: {"error": "..."}
        if (response['error'] != null) {
          return response['error'].toString();
        }

        // Case 4: {"messages": [...] }
        if (response['messages'] is List && response['messages'].isNotEmpty) {
          return response['messages'].first.toString();
        }
      }

      // Case 5: direct string
      if (response is String) {
        return response;
      }
      return "Unexpected erro";
    } catch (e) {
      return "Unexpected erro";
    }
  }

  // Handle Dio exceptions
  static String dioExceptionHandler(DioException e) {
    final response = e.response;

    if (response != null && response.data != null) {
      return "Unexpected error";
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Connection timeout";
    }

    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection";
    }

    return "Unexpected error";
  }
}
