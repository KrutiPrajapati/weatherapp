import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MyTextFormField extends StatelessWidget {

  final TextEditingController searchController;
  final Function onFieldSubmitted;
  final String hintText;
  final Icon icon;

  const MyTextFormField({
    super.key,
    required this.onFieldSubmitted,
    required this.searchController,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder finalBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor),
      borderRadius: BorderRadius.circular(7),
    );

    return TextFormField(
      controller: searchController,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          onFieldSubmitted();
        }
      },
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: whiteColor,
      ),
      decoration: InputDecoration(
        enabledBorder: finalBorder,
        focusedBorder: finalBorder,
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: whiteColor,
        ),
      ),
    );
  }
}
