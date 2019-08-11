import 'package:fish_redux/fish_redux.dart';
import 'package:fish_redux_demo/Home_page/page.dart';
import 'package:fish_redux_demo/login_page/page.dart';
import 'package:flutter/material.dart' hide Action;

void main() => runApp(createApp());

/**
 * 这里照搬了fish_redux官方demo，使用PageRoutes注册管理整个页面
 * 可以实现全局切换状态，例如：更换主题颜色
 * 本Demo没有全局切换状态，如果想参考，可以查阅fish_redux官方demo。
 */
Widget createApp() {
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      /// 注册登陆主页面
      "login": LoginPage(),

      /// 注册首页
      "home": HomePage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      /// AOP
      /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
      /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[safetyAdapter<dynamic>()],

        /// Effect AOP
        effectMiddleware: [
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          //这块主要用到middleware的打印功能，监听Action在页面间的调整过程
          logMiddleware<dynamic>(tag: page.runtimeType.toString()), //这块主要用到middleware的打印功能，监听Action在页面间的调整过程
        ],
      );
    },
  );

  return MaterialApp(
    title: 'fish_redux_demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('login',null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
