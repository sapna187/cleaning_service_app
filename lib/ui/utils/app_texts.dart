import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget customText(
  String text, {
  double size = 14,
  Color color = AppColors.black,
  FontWeight weight = FontWeight.w400,
}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}
