import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/entity/weather.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'action.dart';
import 'state.dart';
import 'weather_adapter/action.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    HomeAction.refresh: _onRefresh,
  });
}

void _init(Action action, Context<HomeState> ctx) {
  ctx.dispatch(HomeActionCreator.onRefresh());
}

void _onRefresh(Action action, Context<HomeState> ctx) async {
  Map<String, dynamic> params = {
    'city': '北京',
  };
  Response response = await Dio().post(
    "https://www.apiopen.top/weatherApi",
    queryParameters: params,
  );
  int code = response.data['code'];
  String msg = response.data['message'];
  Map<String, dynamic> data = response.data['data'];
  List list = data['forecast'];
  List<Weather> weatherList = list.map((m) {
    return new Weather.fromJson(m);
  }).toList();
  if (code == 200) {
    ctx.state.refreshController.refreshCompleted();
    ctx.dispatch(WeatherActionCreator.onSetNewData(weatherList));
    Fluttertoast.showToast(msg: '获取天气信息成功');
  } else {
    ctx.state.refreshController.refreshFailed();
    Fluttertoast.showToast(msg: "获取天气信息失败:$msg");
  }
}
