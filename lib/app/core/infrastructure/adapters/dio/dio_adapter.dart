import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/core/domain/http_adapters/http_response.dart';
import 'package:pokedex/app/core/domain/http_adapters/i_http_client_adapter.dart';
import 'package:pokedex/app/core/domain/repositories/i_repository.dart';
import 'package:pokedex/app/core/infrastructure/adapters/dio/interceptor/common_interceptor.dart';
import 'package:pokedex/app/core/infrastructure/endpoints/endpoints.dart';

import 'dio_errors.dart';

class DioAdapter implements IHttpClientAdapter {
  final Dio dio = Dio();
  final List<InterceptorsWrapper> interceptors = [CommonInterceptor()];
  final IRepository repository = Get.find<IRepository>();

  DioAdapter() {
    dio.options.validateStatus = (status) => status! < 600;
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.baseUrl = API.url;
    if (interceptors.isNotEmpty) dio.interceptors.addAll(interceptors);
  }

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      dynamic cache = await repository.getById(path);
      if (cache != null) {
        return HttpResponse(
          data: cache,
          statusCode: StatusCodeEnum.fromStatusCode(200),
        );
      }
      final result = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      repository.add(path, result.data);
      final response = HttpResponse(
        data: result.data is String ? json.decode(result.data) : result.data,
        statusCode: StatusCodeEnum.fromStatusCode(result.statusCode),
      );
      return response;
    } on DioException catch (e) {
      throw DioClientError(
        data: e.response?.data,
        statusCode: e.response?.statusCode ?? 500,
        type: DioExceptionType.badResponse,
        message: e.message ?? '',
        requestOptions: e.requestOptions,
        stackTrace: e.stackTrace,
      );
    }
  }
}
