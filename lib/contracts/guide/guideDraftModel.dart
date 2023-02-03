import '../generated/guide/add_guide_view_model.dart';

class GuideDraftModel {
  final String selectedLanguage;
  final String assistantAppsToken;
  final void Function(AddGuideViewModel) updateGuide;
  final void Function(String) deleteGuide;
  final void Function() googleLogin;

  GuideDraftModel({
    required this.selectedLanguage,
    required this.assistantAppsToken,
    required this.updateGuide,
    required this.deleteGuide,
    required this.googleLogin,
  });
}
