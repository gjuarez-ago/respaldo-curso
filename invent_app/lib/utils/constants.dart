import 'package:flutter/material.dart';

class Constants {
  static const double padding = 20;
  static const double avatarRadius = 55;
  static const Color blueGeneric = Color.fromARGB(255, 0, 71, 186);

  static const Map<String, String> headersPublic = {
    "Content-Type": "application/json"
  };

  static const Map<String, String> headersProtect = {
    "Content-Type": "application/json",
    'Authorization': 'Bearer ',
  };
}