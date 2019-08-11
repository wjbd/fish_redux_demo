import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: PreferredSize(
      //通过PreferredSize设置appbar的高度
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        //不显示返回键
        centerTitle: true,
        //是否居中，false靠左，true居中
        // brightness: Brightness.dark,//状态栏字体颜色
        elevation: 0,
        //高度
        title: Text('OpeanApi开发者登录'),
      ),
    ),
    body: GestureDetector(
      onTap: () {
        //隐藏输入法
        FocusScope.of(viewService.context).requestFocus(new FocusNode());
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 50, 15, 10),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: state.usernameController,
                    decoration: InputDecoration(
                      hintText: '请输入OpenApi开发者账号',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    dispatch(LoginActionCreator.onClearUsername());
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: state.passwordController,
                    obscureText: true, //设置显示密码
                    decoration: InputDecoration(
                      hintText: '请输入OpenApi开发者密码',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    dispatch(LoginActionCreator.onClearPassword());
                  },
                ),
              ],
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                '登录',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (state.usernameController.text.isNotEmpty) {
                  if (state.passwordController.text.isNotEmpty) {
                    //用户名和密码都不为空的时候进行登录操作
                    dispatch(LoginActionCreator.onLogin());
                  } else {
                    Fluttertoast.showToast(msg: '密码不能为空');
                  }
                } else {
                  Fluttertoast.showToast(msg: '账户不能为空');
                }
              },
            ),
            Text('OpenApi地址：'),
            Text('https://www.apiopen.top/api.html'),
            Text('登录接口地址：'),
            Text('https://api.apiopen.top/developerLogin'),
          ],
        ),
      ),
    ),
  );
}
