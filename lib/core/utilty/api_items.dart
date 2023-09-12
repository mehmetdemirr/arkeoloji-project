enum ApiItem {
  posts,
  login,
  register,
  currentKazi,
  kazi,
}

extension ApiItems on ApiItem {
  String str() {
    switch (this) {
      case ApiItem.posts:
        return "/posts";
      case ApiItem.login:
        return "/auth/login";
      case ApiItem.register:
        return "/user";
      case ApiItem.currentKazi:
        return "/kazi/current";
      case ApiItem.kazi:
        return "/kazi/";
    }
  }
}
