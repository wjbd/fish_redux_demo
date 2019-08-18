import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/entity/weather.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState implements Cloneable<HomeState> {
  RefreshController refreshController;
  List<Weather> list;
  @override
  HomeState clone() {
    return HomeState()
      ..list = list
      ..refreshController = refreshController;
  }
}

HomeState initState(Map<String, dynamic> args) {
  HomeState state = new HomeState();
  state.refreshController = new RefreshController(initialRefresh: false);
  state.list = new List();
  return state;
}
