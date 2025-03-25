import 'dart:typed_data';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracking_app/domain/models.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_cublit.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_states.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCublit, AppStates>(
      builder: (context, state) {
        var _cubit = AppCublit.get(context);
        return ConditionalBuilder(
            condition: _cubit.meals.isNotEmpty,
            builder: (context) {
              return ListView.builder(
                itemCount: _cubit.meals.length,
                itemBuilder: (context, index) {
                  return itemBuilder(
                      context, _cubit.meals[index], width, height, _cubit);
                },
              );
            },
            fallback: (context) => Center(
                  child: Text("No Meals"),
                ));
      },
      listener: (context, state) {},
    );
  }

  Widget itemBuilder(context, Meal meal, width, height, AppCublit cubit) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSize.s16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppSize.s18,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          maxLines: 1,
                          "Do you Want To Delete This Meal !",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppSize.s28,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    ColorManager.lightGrey)),
                            onPressed: () async {
                              await cubit.deleteMeal(meal.id);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Meal Deleted Successfully'),
                              ));
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Yes",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    ColorManager.lightGrey)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "No",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
            spacing: AppSize.s12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: Image.memory(
                  meal.image,
                  height: height / 3.5,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                "Name: ${meal.name}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Calories: ${meal.calories}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Time: ${meal.time}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ]),
      )),
    );
  }
}
