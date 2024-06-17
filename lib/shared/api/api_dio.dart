import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

class Api {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // static const basePath = 'http://192.168.0.191:5000';
  static const basePath = 'https://ratingus.fun/spring-api';

  void init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        options.path = basePath + options.path;

        debugPrint("start req");
        final token = await secureStorage.read(key: 'token');
        if (await isTokenExpired()) {
          debugPrint("token expired!");
          options.headers['Authorization'] = 'Bearer  ';
        } else {
          debugPrint("token okay!");
          options.headers['Authorization'] = 'Bearer $token';
        }

        debugPrint("req go!");
        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
            debugPrint("start resp!");
        final setCookie = response.headers['Set-Cookie'];
        if (setCookie != null && setCookie.isNotEmpty) {
          final token = _extractTokenFromSetCookie(setCookie.first);
          debugPrint("token: $token");
          if (token != null) {
            debugPrint("await secure!");
            await secureStorage.write(key: 'token', value: token);
            debugPrint("success secure!");
          }
        }
            debugPrint("lets go!!");
        return handler.next(response);
      },
      onError: (
        DioException error,
        ErrorInterceptorHandler handler,
      ) async {
        debugPrint("error: ${error.response?.statusCode}");
        if (error.response?.statusCode == 403) {
          GetIt.I<AppRouter>().popAndPush(const LoginRoute());
          await secureStorage.delete(key: 'token');
        }
        return handler.next(error);
      },
    ));
  }

  String? _extractTokenFromSetCookie(String setCookie) {
    final regExp = RegExp(r'token=([^;]+);');
    final match = regExp.firstMatch(setCookie);
    if (match != null && match.groupCount > 0) {
      return match.group(1);
    }
    return null;
  }

  Future<JWT> decodeToken() async {
    final token = await secureStorage.read(key: 'token');
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      return JWT.fromJson(decodedToken);
    }
    throw "Нет токена";
  }

  Future<bool> isTokenExpired() async {
    final token = await secureStorage.read(key: 'token');
    if (token != null) {
      var isExpired = JwtDecoder.isExpired(token);
      if (isExpired) await secureStorage.delete(key: 'token');
      return isExpired;
    }
    return true;
  }

  logout() {
    secureStorage.delete(key: 'token');
    GetIt.I<AppRouter>().popAndPush(const LoginRoute());
  }
}
