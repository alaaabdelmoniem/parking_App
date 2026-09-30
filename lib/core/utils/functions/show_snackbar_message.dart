import 'package:flutter/material.dart';

void showSnackbarMessage(BuildContext context,{required Widget content ,required Color color}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: content,backgroundColor: color,) );
}