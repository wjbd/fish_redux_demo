import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/entity/weather.dart';

class DialogState implements Cloneable<DialogState> {
  Weather weather;
  @override
  DialogState clone() {
    return DialogState()..weather = weather;
  }
}
