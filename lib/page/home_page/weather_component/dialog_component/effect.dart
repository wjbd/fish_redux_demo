import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<DialogState> buildEffect() {
  return combineEffects(<Object, Effect<DialogState>>{
    DialogAction.cancel: _onCancel,
  });
}

void _onCancel(Action action, Context<DialogState> ctx) {
  Navigator.of(ctx.context).pop();
}
