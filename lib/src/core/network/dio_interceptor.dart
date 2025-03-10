import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DioInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  const DioInterceptor(this.dio, this.ref);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    if (err.response?.statusCode == 401) {}
  }
}
