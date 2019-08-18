import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/entity/weather.dart';
import 'package:fish_redux_demo/page/home_page/weather_component/component.dart';
import 'package:fish_redux_demo/page/home_page/weather_component/state.dart';

import '../state.dart';
import 'reducer.dart';

class WeatherAdapter extends DynamicFlowAdapter<HomeState> {
  WeatherAdapter()
      : super(
          pool: <String, Component<Object>>{
            "weather": WeatherComponent(),
          },
          connector: _WeatherConnector(),
          reducer: buildReducer(),
        );
}

class _WeatherConnector extends ConnOp<HomeState, List<ItemBean>> {
  @override
  List<ItemBean> get(HomeState state) {
    if (state.list?.isNotEmpty == true) {
      return state.list.map<ItemBean>((m) {
        WeatherState state = new WeatherState();
        state.weather = m;
        return ItemBean("weather", state);
      }).toList();
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(HomeState state, List<ItemBean> items) {
    if (items.isNotEmpty == true) {
      state.list = List<Weather>.from(items.map((m) {
        return m.data;
      }).toList());
    } else {
      state.list = new List();
    }
  }
}
