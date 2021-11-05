import 'package:flutter/material.dart';
import 'package:zzreader/ui/pages/home/home.dart';
class ZZRouter {
  static final String initialRouter = ZZHomeScreen.routeName;

  static final Map<String, Widget Function(BuildContext)> routers = {
    ZZHomeScreen.routeName: (ctx) => ZZHomeScreen(),
  };

  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}