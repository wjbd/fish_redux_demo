import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'action.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      WeatherAction.setNewData: _setNewData,
      WeatherAction.setEmptyData: _setEmptyData,
    },
  );
}

HomeState _setNewData(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.list = action.payload;
  return newState;
}

HomeState _setEmptyData(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.list.clear();
  return newState;
}
