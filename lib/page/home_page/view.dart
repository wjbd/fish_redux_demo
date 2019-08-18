import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text('首页'),
      ),
    ),
    body: Container(
      child: SmartRefresher(
        header: ClassicHeader(),
        controller: state.refreshController,
        onRefresh: () {
          dispatch(HomeActionCreator.onRefresh());
        },
        child: ListView.builder(
          itemCount: adapter.itemCount,
          itemBuilder: adapter.itemBuilder,
        ),
      ),
    ),
  );
}
