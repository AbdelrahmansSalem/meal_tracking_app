import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracking_app/app/di.dart';
import 'package:meal_tracking_app/data/db_factory.dart';
import 'package:meal_tracking_app/data/db_service_client.dart';
import 'package:meal_tracking_app/domain/models.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_states.dart';
import 'package:meal_tracking_app/presentation/meal_adding_screen/meal_adding_screen.dart';
import 'package:meal_tracking_app/presentation/meals_screen/meals_screen.dart';

class AppCublit extends Cubit<AppStates> {
  AppCublit() : super(AppInitalState());

  static AppCublit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  File? imageFile = null;

  final List<Widget> screens = [MealsScreen(), MealAddingScreen()];
  final List<BottomNavigationBarItem> list = [
    BottomNavigationBarItem(
        icon: Icon(Icons.food_bank_rounded), label: "My Meals"),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_sharp), label: "Add Meal"),
  ];
  int currentIndex = 0;
  void changeBottomNavIndex({required int index}) {
    currentIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  selectImage(File imageTemp) {
    imageFile = imageTemp;
    emit(SelectImageState());
  }

  insertToDatabase() async {
    Meal meal = Meal(
        null,
        nameController.text.trim(),
        caloriesController.text.trim(),
        timeController.text.trim(),
        await imageFile!.readAsBytes());
    emit(InsertToDatabaseLoadingState());
    await instance<DbServiceClient>().insertToDatabase(meal);
    emit(InsertToDatabaseSuccessState());
    resetValues();
    getData();
  }

  List<Meal> meals = [];

  resetValues() {
    nameController.text = '';
    caloriesController.text = '';
    timeController.text = '';
    imageFile = null;
  }

  getData() {
    emit(GetDataLoadingState());
    var list = instance<DbServiceClient>().getData().then((value) {
      meals = value.toDomain();
      print(meals[0].image);
      emit(GetDataSuccessState());
    });
  }

  deleteMeal(int? id) async {
    emit(DeleteMealLoadingState());
    await instance<DbServiceClient>().deleteFromDatabase(id: id!);
    emit(DeleteMealSuccessState());
    getData();
  }

  List<String> filter_list = ['Name', "Calories", 'Time'];

  void changeFilterList(String? value) {
    if (value == filter_list[0]) {
      meals.sort((a, b) => a.name.compareTo(b.name));
    } else if (value == filter_list[1]) {
      meals.sort((a, b) =>
          double.parse(a.calories).compareTo(double.parse(b.calories)));
    } else if (value == filter_list[2]) {
      meals.sort((a, b) => a.time.compareTo(b.time));
    }
    emit(ChangeFilterListState());
  }
}
