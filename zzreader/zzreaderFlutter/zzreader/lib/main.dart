import 'package:flutter/material.dart';
import 'package:zzreader/core/router/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ZZRouter.initialRouter,
      routes: ZZRouter.routers,
    );
  }
}

