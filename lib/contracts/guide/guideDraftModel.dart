import '../generated/guide/addGuideViewModel.dart';

class GuideDraftModel {
  final String selectedLanguage;
  final void Function(AddGuideViewModel) updateGuide;
  final void Function(String) deleteGuide;

  GuideDraftModel({
    required this.selectedLanguage,
    required this.updateGuide,
    required this.deleteGuide,
  });
}
