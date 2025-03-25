import 'package:flutter/material.dart';

Widget defualtTextFormField(
    {required TextEditingController controller,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    void Function()? onFieldTap,
    bool obscureText = false,
    IconData? suffix,
    IconData? prefix,
    String? hintText,
    String? labelText,
    TextInputType? type,
    required BuildContext context}) {
  return TextFormField(
    style: Theme.of(context).textTheme.bodyMedium,
    controller: controller,
    validator: validator,
    onChanged: onChanged,
    textAlign: TextAlign.start,
    onTap: onFieldTap,
    keyboardType: type,
    obscureText: obscureText,
    decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(suffix),
            prefixIcon: Icon(prefix),
            hintText: hintText,
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            hintStyle: Theme.of(context).textTheme.displayMedium)
        .applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}
