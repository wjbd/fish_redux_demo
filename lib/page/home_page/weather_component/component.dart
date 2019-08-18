import 'package:fish_redux/fish_redux.dart';

import 'dialog_component/component.dart';
import 'effect.dart';
import 'state.dart';
import 'view.dart';

class WeatherComponent extends Component<WeatherState> {
  WeatherComponent()
      : super(
            effect: buildEffect(),
            view: buildView,
            dependencies: Dependencies<WeatherState>(
                slots: <String, Dependent<WeatherState>>{
                  'dialog': DialogConnector() + DialogComponent(),
                }),);

}
