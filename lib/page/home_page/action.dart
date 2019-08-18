import 'package:fish_redux/fish_redux.dart';

enum HomeAction { refresh }

class HomeActionCreator {
  static Action onRefresh() {
    return const Action(HomeAction.refresh);
  }

}
