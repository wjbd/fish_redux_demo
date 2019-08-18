import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import '../config.dart';
import 'action.dart';
import 'state.dart';

Effect<RegisterState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterState>>{
    RegisterAction.register: _onRegister,
  });
}

void _onRegister(Action action, Context<RegisterState> ctx) async {
  //这里没有对网络请求层继续封装，可以根据自己的习惯进行封装网络请求，简化这里的代码
  Map<String, dynamic> params = {
    'name': ctx.state.usernameController.text,
    'passwd': ctx.state.passwordController.text,
    'apikey': Config.apikey,
  };
  Response response = await Dio().post(
    "https://api.apiopen.top/registerUser",
    queryParameters: params,
  );
  int code = response.data['code'];
  String msg = response.data['message'];
  if (code == 200) {
    Fluttertoast.showToast(msg: '注册成功成功，跳转登录页面');
    Navigator.of(ctx.context).pop();
  } else {
    Fluttertoast.showToast(msg: "注册失败:$msg");
  }
}
