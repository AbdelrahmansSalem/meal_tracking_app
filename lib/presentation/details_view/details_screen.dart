import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, this.meal});

  final meal;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: height / 1.5,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                meal['strMeal'],
                style: TextStyle(
                  color: ColorManager.white,
                  shadows: [
                    Shadow(
                      color: ColorManager.black..withValues(alpha: 0.7),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: meal['strMealThumb'],
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.lightGrey,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported,
                      size: AppSize.s60,
                    ),
                    fadeInDuration: Duration(milliseconds: 1500),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(AppSize.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSize.s8,
                    children: [
                      // Meal Title
                      Row(
                        spacing: AppSize.s16,
                        children: [
                          Text(meal['strMeal'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: ColorManager.black)),
                          Expanded(
                            child: Chip(
                              label: Text(
                                meal['strCategory'],
                                style: TextStyle(color: ColorManager.white),
                              ),
                              backgroundColor: ColorManager.primary,
                            ),
                          ),
                          Expanded(
                            child: Chip(
                              label: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  meal['strArea'],
                                  style: TextStyle(color: ColorManager.white),
                                ),
                              ),
                              backgroundColor: ColorManager.secondary,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'Instructions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        meal['strInstructions'],
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),

                      Text(
                        'Ingredients',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppSize.s16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(20, (index) {
                              final ingredient =
                                  meal['strIngredient${index + 1}'];
                              final measure = meal['strMeasure${index + 1}'];
                              if (ingredient != null &&
                                  ingredient.isNotEmpty &&
                                  measure != null &&
                                  measure.isNotEmpty) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: ColorManager.primary,
                                          size: AppSize.s16),
                                      SizedBox(width: AppSize.s8),
                                      Expanded(
                                        child: Text(
                                          '$ingredient - $measure',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox();
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
