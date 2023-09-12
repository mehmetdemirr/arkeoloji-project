import 'package:flutter/material.dart';

enum BorderRadiusItem {
  small,
  medium,
  large,
}

extension BorderItems on BorderRadiusItem {
  BorderRadius str() {
    switch (this) {
      case BorderRadiusItem.small:
        return const BorderRadius.all(Radius.circular(10));
      case BorderRadiusItem.medium:
        return const BorderRadius.all(Radius.circular(15));
      case BorderRadiusItem.large:
        return const BorderRadius.all(Radius.circular(25));
    }
  }
}
