import 'package:flutter/material.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_layout.dart';
import 'package:meal_tracking_app/presentation/resources/theme_manager.dart';

class App extends StatelessWidget {
  const App._internal();
  static const App _inatace = App._internal();
  factory App() => _inatace;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        home: AppLayout());
  }
}
