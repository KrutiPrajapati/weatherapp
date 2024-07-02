import 'package:flutter/material.dart';
import 'colors.dart';

showSnackBar(BuildContext context, String text){
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text,
        style: const TextStyle(
            fontSize: 14
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      animation: ProxyAnimation(),
    ),
  );
}

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: whiteColor,
        ),
      );
    },
  );
}

void cancelLoadingCircle(BuildContext context) {
  Navigator.of(context).pop();
}