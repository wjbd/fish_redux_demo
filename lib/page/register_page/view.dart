import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(RegisterState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: PreferredSize(
      //通过PreferredSize设置appbar的高度
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        //不显示返回键
        automaticallyImplyLeading: true,
        //是否居中，false靠左，true居中
        centerTitle: true,
        elevation: 0,
        //高度
        title: Text('注册'),
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
                      hintText: '请输入账号',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    dispatch(RegisterActionCreator.onClearUsername());
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
                      hintText: '请输入密码',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    dispatch(RegisterActionCreator.onClearPassword());
                  },
                ),
              ],
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                '注册',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (state.usernameController.text.isNotEmpty) {
                  if (state.passwordController.text.isNotEmpty) {
                    //用户名和密码都不为空的时候进行登录操作
                    dispatch(RegisterActionCreator.onRegister());
                  } else {
                    Fluttertoast.showToast(msg: '密码不能为空');
                  }
                } else {
                  Fluttertoast.showToast(msg: '账户不能为空');
                }
              },
            ),
            Text('本Demo使用的接口为OpenApi，所有接口文档和传参，可以查看官网demo'),
            Text('OpenApi地址：'),
            Text('https://www.apiopen.top/api.html'),
          ],
        ),
      ),
    ),
  );
}
