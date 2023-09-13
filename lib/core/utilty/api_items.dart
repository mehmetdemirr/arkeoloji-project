enum ApiItem {
  posts,
  login,
  user,
  currentKazi,
  kazi,
  acma,
  acmaBilgi,
}

extension ApiItems on ApiItem {
  String str() {
    switch (this) {
      case ApiItem.posts:
        return "/posts";
      case ApiItem.login:
        return "/auth/login";
      case ApiItem.user:
        return "/user";
      case ApiItem.currentKazi:
        return "/kazi/current";
      case ApiItem.kazi:
        return "/kazi/";
      case ApiItem.acma:
        return "/acma/";
      case ApiItem.acmaBilgi:
        return "/acma-bilgi/";
    }
  }
}
