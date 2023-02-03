import '../integration/dependency_injection.dart';

String getImagePath(String imagePath, {String? imagePackage}) {
  String prefix = '';
  if (imagePackage == null) {
    String imageAssetsPathPrefix = getPath().imageAssetPathPrefix;
    if (!imagePath.contains(imageAssetsPathPrefix)) {
      prefix = '$imageAssetsPathPrefix/';
    }
  }
  return '$prefix$imagePath';
}
