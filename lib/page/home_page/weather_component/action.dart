import 'package:fish_redux/fish_redux.dart';

enum WeatherAction { showDialog }

class WeatherActionCreator {
  static Action onShowDialog() {
    return const Action(WeatherAction.showDialog);
  }
}
