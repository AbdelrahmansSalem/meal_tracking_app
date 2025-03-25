import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracking_app/app/app.dart';
import 'package:meal_tracking_app/app/bloc_observer.dart';
import 'package:meal_tracking_app/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await initAppModule();
  runApp(App());
}
