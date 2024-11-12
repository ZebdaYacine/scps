// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class DioErr {
  DioExceptionType type;
  DioErr({
    required this.type,
  });

  String getErr() {
    switch (type) {
      case DioExceptionType.connectionTimeout ||
            DioExceptionType.receiveTimeout:
        return "Connection timed out.";
      case DioExceptionType.badResponse:
        return "Received an invalid response from the server.";
      case DioExceptionType.connectionError:
        return "No internet connection or server is down.";
      default:
        return "An unknown error occurred: $type";
    }
  }
}
