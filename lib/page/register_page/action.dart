import 'package:fish_redux/fish_redux.dart';

enum RegisterAction {
  register,
  clearUsername,
  clearPassword,
}

class RegisterActionCreator {
  static Action onRegister() {
    return const Action(RegisterAction.register);
  }

  static Action onClearUsername() {
    return const Action(RegisterAction.clearUsername);
  }

  static Action onClearPassword() {
    return const Action(RegisterAction.clearPassword);
  }
}
