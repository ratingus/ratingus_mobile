import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

class Api {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static const basePath = 'http://192.168.0.191:5000';

  void init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        options.path = basePath + options.path;

        final token = await secureStorage.read(key: 'token');
        if (await isTokenExpired()) {
          options.headers['Authorization'] = 'Bearer  ';
        } else {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        if (response.statusCode == 403) {
          GetIt.I<AppRouter>().replace(const LoginRoute());
        } else {
          final setCookie = response.headers['Set-Cookie'];
          if (setCookie != null && setCookie.isNotEmpty) {
            final token = _extractTokenFromSetCookie(setCookie.first);
            if (token != null) {
              await secureStorage.write(key: 'token', value: token);
            }
          }
          return handler.next(response);
        }
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
}
