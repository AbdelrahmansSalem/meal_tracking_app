import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_cublit.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_states.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCublit>(
        create: (context) => AppCublit()..getData(),
        child: BlocConsumer<AppCublit, AppStates>(
          builder: (context, state) {
            var _cubit = AppCublit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("Meal Tracking"),
                actions: [
                  DropdownButton(
                      iconSize: AppSize.s28,
                      padding: EdgeInsets.only(right: AppSize.s16),
                      icon: Icon(
                        Icons.filter_list_rounded,
                        color: ColorManager.secondary,
                      ),
                      elevation: 16,
                      isDense: true,
                      underline: Container(),
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      items: _cubit.filter_list
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        _cubit.changeFilterList(value);
                      })
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: _cubit.list,
                currentIndex: _cubit.currentIndex,
                onTap: (value) {
                  _cubit.changeBottomNavIndex(index: value);
                },
              ),
              body: _cubit.screens[_cubit.currentIndex],
            );
          },
          listener: (context, state) {},
        ));
  }
}
