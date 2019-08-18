import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/entity/weather.dart';

import 'dialog_component/state.dart';

class WeatherState implements Cloneable<WeatherState> {
  Weather weather;
  @override
  WeatherState clone() {
    return WeatherState()..weather = weather;
  }
}

class DialogConnector extends ConnOp<WeatherState, DialogState> {
  @override
  DialogState get(WeatherState state) {
    return DialogState()..weather = state.weather;
  }
}
