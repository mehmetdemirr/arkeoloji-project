import 'package:flutter/material.dart';

enum ColorItem {
  white,
  black,
}

extension ColorItems on ColorItem {
  Color str() {
    switch (this) {
      case ColorItem.white:
        return Colors.white;
      case ColorItem.black:
        return Colors.black;
    }
  }
}
