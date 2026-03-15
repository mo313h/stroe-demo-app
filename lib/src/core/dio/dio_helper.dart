import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'end_points.dart';
import 'error_handler.dart';

final dioHelperProvider = Provider((ref) => DioHelper(ref));

class DioHelper {
  static late Dio dio;
  late final Ref ref;

  DioHelper(this.ref);
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        followRedirects: false,
        // will not throw errors
      ),
    );
    // dio.interceptors.add(
    //   PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 90,
    //   ),
    // );
    dio.interceptors.add(
      InterceptorsWrapper(
        // onResponse: (response, handler) {
        //   if (response.statusCode == 401) {
        //     if (response.requestOptions.path == EndPoints.requestOtp) {
        //       return handler.next(response);
        //     }
        //     // using navigator
        //     goRouter.push(RouteConstants.signIn);
        //     AuthRepository.clearLocalDetails();
        //   }
        //   return handler.next(response);
        // },
        // onError: (DioException error, handler) {
        //   if (error.response?.statusCode == 401) {
        //     goRouter.push(RouteConstants.signIn);
        //     AuthRepository.clearLocalDetails();
        //   }
        //   return handler.next(error);
        // },
      ),
    );
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    int? userId,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: query,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (error) {
      throw AppException(ErrorHandler.getErrorMsg(error));
    }
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    int? userId,
  }) async {
    try {
      return await dio.post(
        url,
        queryParameters: query,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (error) {
      throw AppException(ErrorHandler.getErrorMsg(error));
    }
  }

  Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    int? userId,
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } on DioException catch (error) {
      throw AppException(ErrorHandler.getErrorMsg(error));
    }
  }

  Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    int? userId,
  }) async {
    try {
      Response response = await dio.patch(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } on DioException catch (error) {
      throw AppException(ErrorHandler.getErrorMsg(error));
    }
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    int? userId,
  }) async {
    try {
      final response = await dio.delete(
        url,
        queryParameters: query,
        data: data,
      );

      return response;
    } on DioException catch (error) {
      throw AppException(ErrorHandler.getErrorMsg(error));
    }
  }
}
