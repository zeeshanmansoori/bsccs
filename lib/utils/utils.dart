class Utils {
  static String getLottiePath(String name) {
    return "assets/lottie/$name.json";
  }

  static String getImagePath(String name) {
    return "assets/images/$name.png";
  }

  static bool isSvgFile(String name) {
    return name.contains(".svg");
  }
}
