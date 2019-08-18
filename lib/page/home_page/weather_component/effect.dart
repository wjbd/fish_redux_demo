import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<WeatherState> buildEffect() {
  return combineEffects(<Object, Effect<WeatherState>>{
    WeatherAction.showDialog: _onShowDialog,
  });
}

void _onShowDialog(Action action, Context<WeatherState> ctx) {
  showDialog(
    context: ctx.context,
    builder: (BuildContext context) {
      return ctx.buildComponent('dialog');
    },
  );
}
