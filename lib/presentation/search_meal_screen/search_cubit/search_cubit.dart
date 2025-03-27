import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracking_app/app/di.dart';
import 'package:meal_tracking_app/data/remote_data/remote_data_source.dart';
import 'package:meal_tracking_app/presentation/search_meal_screen/search_cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitalState());
  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();

  List<dynamic>? finalList = [];

  List<dynamic>? categoryMeals = [];
  List<dynamic>? searchMeals = [];

  String categoryValue = 'All';
  List<String> categoryList = [
    'All',
    'Miscellaneous',
    'Seafood',
    'Side',
    'Vegetarian',
    'Beef',
    'Pasta',
    'Dessert',
    'Lamb',
    'Chicken'
  ];

  Timer? _checkTypingTimer;

  startTimer() {
    _checkTypingTimer = Timer(const Duration(milliseconds: 500), () {
      //set your desired duration
      //perform your logic here
      searchMeal();
    });
  }

  resetTimer() {
    _checkTypingTimer?.cancel();
    startTimer();
  }

  searchMeal() async {
    emit(SearchLoadingState());
    searchMeals =
        await instance<RemoteDataSource>().serachMeal(searchController.text);
    finalList = searchMeals;
    emit(SearchSuccessState());
  }

  searchCategory(String category) async {
    emit(SearchLoadingState());
    categoryMeals = await instance<RemoteDataSource>().serachCategory(category);
    categoryValue = category;
    filterData();
    emit(SearchSuccessState());
  }

  filterData() {
    if (categoryMeals != null && searchMeals != null) {
      finalList = [];
      finalList = searchMeals!
          .where((meal) => categoryMeals!
              .any((categoryMeal) => categoryMeal['idMeal'] == meal['idMeal']))
          .toList();
    } else if (categoryValue == categoryList.first) {
      finalList = searchMeals;
    } else {
      finalList = [];
    }
    emit(ChangeFilterListState());
  }
}
