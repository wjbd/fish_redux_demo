import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class RegisterState implements Cloneable<RegisterState> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  RegisterState clone() {
    return RegisterState()
      ..passwordController = passwordController
      ..usernameController = usernameController;
  }
}

RegisterState initState(Map<String, dynamic> args) {
  RegisterState state = new RegisterState();
  state.usernameController = new TextEditingController();
  state.passwordController = new TextEditingController();
  return state;
}
