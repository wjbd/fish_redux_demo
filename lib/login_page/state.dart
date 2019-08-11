import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class LoginState implements Cloneable<LoginState> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  LoginState clone() {
    return LoginState()
      ..passwordController = passwordController
      ..usernameController = usernameController;
  }
}

LoginState initState(Map<String, dynamic> args) {
  LoginState state = new LoginState();
  state.usernameController = new TextEditingController();
  state.passwordController = new TextEditingController();
  return state;
}
