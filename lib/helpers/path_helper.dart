import '../integration/dependency_injection.dart';

String getImagePath(String imagePath, {String? imagePackage}) {
  if (imagePackage == null) {
    return getPath().ofImage(imagePath);
  }
  return imagePath;
}
