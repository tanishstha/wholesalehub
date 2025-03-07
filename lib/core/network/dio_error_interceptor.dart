import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log the error details
    print('Dio Error: ${err.message}');
    if (err.response != null) {
      // Handle server errors
      if (err.response!.statusCode! >= 300) {
        print('Error Response: ${err.response!.data}');
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: err.response!.data['message'] ?? err.response!.statusMessage!,
          type: err.type,
        );
      } else {
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'Something went wrong',
          type: err.type,
        );
      }
    } else {
      // Handle connection errors
      err = DioException(
        requestOptions: err.requestOptions,
        error: 'Connection error: ${err.message}',
        type: err.type,
      );
    }
    super.onError(err, handler);
  }
}
