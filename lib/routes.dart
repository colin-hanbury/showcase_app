import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:showcase_app/showcase_app.dart';
import 'package:showcase_app/views/home_page.dart';

class Routes {
  static const String root = 'root';
  static const String home = 'home';
  static const String settings = 'settings';
}

PageRoute<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.root:
      return pageRouter(const RootPage());
    case Routes.home:
      return pageRouter(const HomePage());
    case Routes.settings:
      return pageRouter(const HomePage());
    default:
      return pageRouter(const RootPage());
  }
}

PageRoute pageRouter(Widget widget) {
  return !kIsWeb && (Platform.isIOS || Platform.isMacOS)
      ? CupertinoPageRoute(builder: (context) => widget)
      : MaterialPageRoute(builder: (context) => widget);
}
