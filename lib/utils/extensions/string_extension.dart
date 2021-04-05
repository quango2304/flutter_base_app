import 'package:flutter/material.dart';

extension TextStyleExtensions on String {
  Text black14Bold(String text, {TextStyle? style}) {
    return Text(
      text, style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ).merge(style),
    );
  }
}