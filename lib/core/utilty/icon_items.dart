import 'package:flutter/material.dart';

enum IconItem {
  home,
  setting,
}

extension IconItems on IconItem {
  Widget str() {
    switch (this) {
      case IconItem.home:
        return const Icon(Icons.home);
      case IconItem.setting:
        return const Icon(Icons.settings);
    }
  }
}
