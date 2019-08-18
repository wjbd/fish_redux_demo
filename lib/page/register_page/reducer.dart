import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegisterState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterState>>{
      RegisterAction.clearUsername: _clearUsername,
      RegisterAction.clearPassword: _clearPasswrod,
    },
  );
}

RegisterState _clearUsername(RegisterState state, Action action) {
  final RegisterState newState = state.clone();
  newState.usernameController.clear(); //在这里设置username输入框为空
  return newState;
}

RegisterState _clearPasswrod(RegisterState state, Action action) {
  final RegisterState newState = state.clone();
  newState.passwordController.clear(); //在这里设置清空password输入框为空
  return newState;
}
