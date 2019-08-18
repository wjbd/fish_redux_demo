import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'state.dart';
import 'view.dart';
import 'weather_adapter/adapter.dart';

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<HomeState>(
            adapter: NoneConn<HomeState>() + WeatherAdapter(),
          ),
        );
}
