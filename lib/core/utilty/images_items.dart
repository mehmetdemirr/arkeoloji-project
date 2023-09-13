enum ImageItem {
  image,
  arkeoloji,
  foto,
  spalsh,
}

String defaultValue = "assets/images";

extension ImageItems on ImageItem {
  String str() {
    switch (this) {
      case ImageItem.image:
        return "$defaultValue/image.png";
      case ImageItem.arkeoloji:
        return "$defaultValue/arkeoloji.jpeg";
      case ImageItem.foto:
        return "$defaultValue/foto.png";
      case ImageItem.spalsh:
        return "$defaultValue/splash.png";
    }
  }
}
