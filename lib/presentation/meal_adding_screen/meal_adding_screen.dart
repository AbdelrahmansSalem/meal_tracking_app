import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_cublit.dart';
import 'package:meal_tracking_app/presentation/app_layout/app_cubit/app_states.dart';
import 'package:meal_tracking_app/presentation/resources/color_manager.dart';
import 'package:meal_tracking_app/presentation/resources/components.dart';
import 'package:meal_tracking_app/presentation/resources/size_manager.dart';

class MealAddingScreen extends StatelessWidget {
  MealAddingScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCublit, AppStates>(
      builder: (context, state) {
        var _cubit = AppCublit.get(context);
        return Container(
          padding: EdgeInsets.all(AppSize.s16),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: AppSize.s24,
                children: [
                  defualtTextFormField(
                      context: context,
                      controller: _cubit.nameController,
                      hintText: 'Meal Name',
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name Must Not Be Empty";
                        }
                        return null;
                      },
                      prefix: Icons.title_outlined),
                  defualtTextFormField(
                      context: context,
                      controller: _cubit.caloriesController,
                      hintText: 'Meal Calories',
                      type: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Calories Must Not Be Empty";
                        }
                        return null;
                      },
                      prefix: Icons.energy_savings_leaf_rounded),
                  defualtTextFormField(
                      onFieldTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          _cubit.timeController.text = value!.format(context);
                        });
                      },
                      context: context,
                      controller: _cubit.timeController,
                      hintText: 'Meal Time',
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Time Must Not Be Empty";
                        }
                        return null;
                      },
                      prefix: Icons.watch_later_outlined),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        final imageTemp = File(image.path);
                        _cubit.selectImage(imageTemp);
                        print(imageTemp);
                      } on PlatformException catch (e) {
                        print('Failed to pick image: $e');
                      }
                    },
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      spacing: AppSize.s22,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: AppSize.s28,
                        ),
                        Text(
                          "Select Meal Image",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  if (_cubit.imageFile != null) ...[
                    Image.file(
                      _cubit.imageFile!,
                      fit: BoxFit.fill,
                      width: width / 1.2,
                      height: height / 3.5,
                    )
                  ],
                  ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (_cubit.imageFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Select Your image !'),
                            ));
                          } else {
                            await _cubit.insertToDatabase();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Meal Added Successfully'),
                            ));
                          }
                        }
                      },
                      child: Text(
                        "Save Meal",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ))
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
