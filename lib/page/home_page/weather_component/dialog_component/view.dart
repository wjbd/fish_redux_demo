import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DialogState state, Dispatch dispatch, ViewService viewService) {
  return AlertDialog(
    title: Text(state.weather.date + "," + state.weather.high + "," + state.weather.low + "," + state.weather.type),
    actions: <Widget>[
      new FlatButton(
        child: new Text("关闭"),
        onPressed: () {
          dispatch(DialogActionCreator.onCancel());
        },
      ),
    ],
  );
}
