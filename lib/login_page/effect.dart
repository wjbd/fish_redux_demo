import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.login: _onLogin,
  });
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  //这里没有对网络请求层继续封装，可以根据自己的习惯进行封装网络请求，简化这里的代码
  Map<String, dynamic> params = {
    'name': ctx.state.usernameController.text,
    'passwd': ctx.state.passwordController.text,
  };
  Response response = await Dio().post(
    "https://api.apiopen.top/developerLogin",
    queryParameters: params,
  );
  int code = response.data['code'];
  String msg = response.data['message'];
  if (code == 200) {
    Fluttertoast.showToast(msg: '登录成功，跳转HomePage');
    Navigator.of(ctx.context).pushNamed('home', arguments: null);
  } else {
    Fluttertoast.showToast(msg: "登录失败:$msg");
  }
}
