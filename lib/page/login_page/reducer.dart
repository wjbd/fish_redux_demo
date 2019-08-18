import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.clearUsername: _clearUsername,
      LoginAction.clearPassword: _clearPasswrod,
    },
  );
}

LoginState _clearUsername(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.usernameController.clear(); //在这里设置username输入框为空
  return newState;
}

LoginState _clearPasswrod(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.passwordController.clear(); //在这里设置清空password输入框为空
  return newState;
}
