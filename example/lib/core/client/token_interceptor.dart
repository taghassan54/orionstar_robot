import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:orionstar_robot_example/core/client/user_session.dart';
import 'package:injectable/injectable.dart';


@Injectable(order: -1)
class TokenInterceptor extends Interceptor {

  final IUserSession _userSession;

  TokenInterceptor(this._userSession);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
   /* if (_userSession.hasToken()) {
      var token = _userSession.getUserToken();
      if (token.isNotEmpty) {
        options.headers['authorization'] = 'Bearer $token';
        debugPrint("token found");
      }
    } else {
      debugPrint("token not found,ignored. probably a guest.");
    }*/
    return super.onRequest(options, handler);
  }
}
