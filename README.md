## 前言
>flutter的优点我就不多说了，现在搞flutter的人越来越多，但是网上查阅的资料不多，大部分的都只能靠自己尝试。今天的Demo主要讲的是fish_redux的实战训练，通过简单的demo完成一个登陆的过程。不涉及fish_redux的高级应用，仅仅是fish_redux的入门实战。
## flutter状态管理
原本在Android开发中是不需要状态管理的，但是接触到了flutter以后，刚开始的时候单一界面，没有抽取Widget以前，使用flutter自带的setState已经足够满足简单APP的要求了。      
随着项目越来越大，单一界面间如果不拆分widget进行管理，一个页面会非常庞大，几千行代码都很正常，这样不仅仅耦合度高，而且修改起来非常麻烦，容易造成因小失大，各种Bug层出不穷。  
在拆分Widget这个大环境下，发现setState这个刷新页面的方法不管用了，因为StatefulWidget的setState方法只对自己的Widget树里的空间可以起刷新作用。  
这个时候就要用到状态管理了，目前主流状态管理方式有四种
- scoped_model（或者provide）
- bloc
- redux
- fish_redux

使用状态管理，然后通过状态切换，去刷新页面。这个是非常好的，而且原生Android开发会感觉非常熟悉，又可以开心的开发Android了。

## fish_redux是什么？
fish_redux作为阿里的闲鱼团队开源的一套比较成熟的框架。这里不再详述，下面参考几个地址，有想了解具体的可以看一下：
- [Github闲鱼地址](https://github.com/alibaba/fish-redux)
- [闲鱼开源fish_redux声明以及非常详细的官方讲解](https://yq.aliyun.com/articles/692549)
- [Fish Redux中的Dispatch是怎么实现的？](https://www.yuque.com/xytech/flutter/gl4zla)
- [阿里云栖-闲鱼技术博客地址](https://yq.aliyun.com/users/rtcqgnmjifzda)

## 为什么选fish_redux？
作者结合自身原生Android开发的时候使用的MVP模式，尝试了主流的四种状态管理后，简单分析一下四种状态管理的优缺点：
- scoped_model（或者provide）
>作为Google原生的状态管理，通过封装InheritedWidget实现了状态管理，而且一并提现Google的设计思想，单一原则，这个Package仅仅作为状态管理来用，几乎没有学习成本，如果是小型项目使用，只用Scoped_model来做状态管理，无疑是非常好的选择，但是越大的项目，使用scoped_model来做状态管理，会有点力不从心。
- bloc
>在没有scoped_model、redux这些状态管理Package之前，bloc是业界最推崇的flutter状态管理工具。而且很好的支持了Stream方式。学习成本较高，大型项目也可以轻松解决。
- redux
>flutter的redux简直是前端开发者的福音，跟React Redux的使用基本保持一致，切换起来非常舒适，方便，非常适合全局状态管理，但是对于没有React经验的人，以及没有使用过Redux的人来说，学习成本非常高。
- fish_redux
>fish_redux的学习成本其实是这几个状态管理里面最高的，但是带来的收益和效果也是最明显，fish_redux是基于redux封装，不仅仅能够满足状态管理，更是集成了配置式的组装项目，Page组装，Component实现，非常干净，易于维护，易于协作没，将集中、分治、复用、隔离做的更进一步，缺点就是代码量的急剧增大。

#### fish_redux是基于Redux数据管理的组装式flutter应用框架，不仅仅完成了状态管理的功能，还让我们的代码拥有统一的编码模型和规范，使用fish_redux让flutter项目更加容易分组开发和维护。

## 撸码开始
### flutter版本和fish_redux版本
>flutter版本为：1.7.8  
fish_redux版本为：0.2.4
### 开发工具
>VSCode  
fish-redux-template插件//用于生成部分重复代码
### 创建项目
创建一个包名为com.lxq.fish_redux_demo且支持AndroidX的flutter项目。
>flutter create --org com.lxq.fish_redux_demo --androidx fish_redux_demo
### 来写主函数
```
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

      /// 注册用户注册页面
      "register":RegisterPage(),

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
```
### LoginPage页面编写  
首先通过fish-redux-template生成Page页面模板，会自动生成以下几个Dart文件
- action
>用来定义在这个页面中发生的动作，例如：登录，清理输入框，更换验证码框等。  
同时可以通过payload参数传值，传递一些不能通过state传递的值。
- effect
>这个dart文件在fish_redux中是定义来处理副作用操作的，比如显示弹窗，网络请求，数据库查询等操作。
- page
>这个dart文件在用来在路由注册，同时完成注册effect，reducer，component，adapter的功能。
- reducer
>这个dart文件是用来更新View，即直接操作View状态。
- state
>state用来定义页面中的数据，用来保存页面状态和数据。
- view
>view很明显，就是flutter里面当中展示给用户看到的页面。
### action
```
enum LoginAction {
  login,
  clearUsername,
  clearPassword,
}

class LoginActionCreator {
  static Action onLogin() {
    return const Action(LoginAction.login);
  }

  static Action onClearUsername() {
    return const Action(LoginAction.clearUsername);
  }
  static Action onClearPassword() {
    return const Action(LoginAction.clearPassword);
  }
}
```
### effect
```
Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.login: _onLogin,
  });
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  //这里没有对网络请求层继续封装，可以根据自己的习惯进行封装网络请求，简化这里的代码
  Map<String, dynamic> params = {
    'name': ctx.state.usernameController.text,
    'passwd': ctx.state.passwordController.text,
  };
  Response response = await Dio().post(
    "https://api.apiopen.top/developerLogin",
    queryParameters: params,
  );
  int code = response.data['code'];
  String msg = response.data['message'];
  if (code == 200) {
    Fluttertoast.showToast(msg: '登录成功，跳转HomePage');
    Navigator.of(ctx.context).pushNamed('home', arguments: null);
  } else {
    Fluttertoast.showToast(msg: "登录失败:$msg");
  }
}
```
### page
```
class LoginPage extends Page<LoginState, Map<String, dynamic>> {
  LoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
```
### reducer
```
Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.clearUsername: _clearUsername,
      LoginAction.clearPassword: _clearPasswrod,
    },
  );
}

LoginState _clearUsername(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.usernameController.clear(); //在这里设置username输入框为空
  return newState;
}

LoginState _clearPasswrod(LoginState state, Action action) {
  final LoginState newState = state.clone();
  newState.passwordController.clear(); //在这里设置清空password输入框为空
  return newState;
}
```
### state
```
class LoginState implements Cloneable<LoginState> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  LoginState clone() {
    return LoginState()
      ..passwordController = passwordController
      ..usernameController = usernameController;
  }
}

LoginState initState(Map<String, dynamic> args) {
  LoginState state = new LoginState();
  state.usernameController = new TextEditingController();
  state.passwordController = new TextEditingController();
  return state;
}
```
### view
```
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
        title: Text('登录'),
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
                      hintText: '请输入密码',
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
            RaisedButton(
              child: Text('注册'),
              onPressed: (){
                Navigator.of(viewService.context).pushNamed('register', arguments: null);
              },
            ),
            Text('OpenApi地址：'),
            Text('https://www.apiopen.top/api.html'),
            Text('登录接口地址：'),
            Text('https://api.apiopen.top/developerLogin'),
            Text('测试账号：1'),
            Text('测试账号密码：1'),
          ],
        ),
      ),
    ),
  );
}
```
## 疑问解答
>1.所有Widget全部改用StatelessWidget?  

答：这个得需要看情况，但是虽然使用fish_redux可以很好的管理状态，但是很明显的问题也存在，就是代码量增大的不是一点点，而是好多好多，所以有的时候要根据实际情况，满足要求即可，另外fish_redux的view分为了page和component，正常情况下，你根本看不到StatelessWidget。
>2.非fish_redux页面，该怎么与fish_redux页面通讯、跳转？

答：这个点是跟正常跳转是一样一样的，没有什么特殊的。

>3.使用fish_redux是否需要一次性全部改造页面

答：没有必要，fish_redux不需要一次性全部改造，可以慢慢改造页面，同时页面之间跳转、传值都不受fish_redux影响。

>4.Action类找不到

答：fish_redux命名和官方有冲突了，这种情况下需要对官方的命名进行隐藏，示例如下：
```
import 'package:flutter/material.dart' hide Action;
```
## 代码地址：
[https://github.com/wjbd/fish_redux_demo](https://github.com/wjbd/fish_redux_demo)

### 非常感谢
- [Github闲鱼地址](https://github.com/alibaba/fish-redux)
- [最简单的fish-redux实例](https://www.jianshu.com/p/f40e72335025)
