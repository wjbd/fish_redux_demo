import 'package:fish_redux/fish_redux.dart';

enum DialogAction { cancel }

class DialogActionCreator {
  static Action onCancel() {
    return const Action(DialogAction.cancel);
  }
}
