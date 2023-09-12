enum ThemeItem {
  light,
  dark,
}

extension ThemeItems on ThemeItem {
  bool str() {
    switch (this) {
      case ThemeItem.light:
        return false;
      case ThemeItem.dark:
        return true;
    }
  }
}
