import 'package:flutter/cupertino.dart';
import '../pages/Home/home_page.dart';
import '../pages/start_page.dart';
import '../pages/User/login.dart';

final Map<String, Function> routes = {
  '/startpage': (contxt, {arguments}) => const StartPage(),
  '/loginpage':(context,{arguments}) => const LoginPage(),
  '/homepage': (contxt, {arguments}) => const HomePage(),

};
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          CupertinoPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
