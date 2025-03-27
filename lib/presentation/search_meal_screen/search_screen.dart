import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracking_app/presentation/details_view/details_screen.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/components.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';
import 'package:meal_tracking_app/presentation/search_meal_screen/search_cubit/search_cubit.dart';
import 'package:meal_tracking_app/presentation/search_meal_screen/search_cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double width = MediaQuery.sizeOf(context).width;
        double height = MediaQuery.sizeOf(context).height;
        var _cubit = SearchCubit.get(context);
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSize.s8),
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSize.s16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: defualtTextFormField(
                          controller: _cubit.searchController,
                          labelText: "Search Meal",
                          hintText: "Search Meal",
                          prefix: Icons.search,
                          onChanged: (p0) {
                            _cubit.resetTimer();
                          },
                          context: context),
                    ),
                    SizedBox(width: AppSize.s8),
                    DropdownMenu(
                      width: width / 3,
                      initialSelection: _cubit.categoryList.first,
                      hintText: "Select Category",
                      requestFocusOnTap: true,
                      enableFilter: true,
                      label: Text('Select Menu'),
                      onSelected: (item) {
                        _cubit.searchCategory(item);
                      },
                      dropdownMenuEntries:
                          _cubit.categoryList.map<DropdownMenuEntry>((item) {
                        return DropdownMenuEntry(
                          value: item,
                          label: item,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                ConditionalBuilder(
                  condition: _cubit.finalList?.length != 0,
                  builder: (context) => searchListBuilder(
                      height, width, _cubit.finalList, _cubit),
                  fallback: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No Data ",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchListBuilder(height, width, list, cubit) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: AppSize.s16,
            crossAxisSpacing: AppSize.s16,
            childAspectRatio: 0.65,
            crossAxisCount: 2),
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return searchItemBuilder(height, width, list[index], context, cubit);
        });
  }

  Widget searchItemBuilder(height, width, meal, context, SearchCubit cubit) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DetailsScreen(meal: meal),
            ));
      },
      child: Column(
        children: [
          Expanded(
            child: Material(
              elevation: AppSize.s8,
              borderRadius: BorderRadius.circular(AppSize.s16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s16),
                child: CachedNetworkImage(
                    imageUrl: meal['strMealThumb'],
                    placeholder: (context, url) => Center(
                          child: const CircularProgressIndicator(
                            color: ColorManager.lightGrey,
                          ),
                        ),
                    errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          size: AppSize.s60,
                        ),
                    fadeInDuration: Duration(milliseconds: 1500),
                    fit: BoxFit.fill,
                    width: width / 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSize.s8),
            child: Row(
              children: [
                Expanded(
                  child: Text(meal['strMeal'],
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                SizedBox(
                  width: AppSize.s4,
                ),
                Text(meal['strCategory'],
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          )
        ],
      ),
    );
  }
}
