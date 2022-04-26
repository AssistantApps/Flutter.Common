import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../contracts/generated/guide/addGuideViewModel.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/guide/guideDraftModel.dart';
import '../../pages/guide/guideAddEditPage.dart';
import '../../pages/guide/guideViewPage.dart';
import '../common/chip.dart';
import '../common/icon.dart';

Widget guideTilePresenter(
    BuildContext context, GuideSearchResultViewModel guide) {
  // Widget imageWidget =
  //     (guide.imageUrl == null || guide.imageUrl.length < 5)
  //         ? localImage(AppImage.error1, boxfit: BoxFit.fitWidth)
  //         : networkImage(post.coverImageUrl, boxfit: BoxFit.fitWidth);
  Widget imageWidget = localImage(getPath().defaultGuideImage);

  List<Widget> firstRow = List.empty(growable: true);
  if (guide.showCreatedByUser && guide.userName.isNotEmpty) {
    firstRow.add(Row(
      children: [
        Icon(Icons.person),
        Text(guide.userName),
      ],
    ));
  }
  if (guide.minutes > 0) {
    firstRow.add(Row(
      children: [
        Icon(Icons.timer),
        Text(getTranslations()
            .fromKey(LocaleKey.minutes)
            .replaceAll('{0}', guide.minutes.toString())),
      ],
    ));
  }
  var bodyWidget = Column(
    children: <Widget>[
      imageWidget,
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: firstRow,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4, right: 4, left: 4),
        child: Text(
          guide.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: guide.tags
            .map((tag) => genericChip(context, tag, color: Colors.transparent))
            .toList(),
      ),
    ],
  );
  return wrapInCommonCard(
    bodyWidget,
    onTap: () async => await getNavigation().navigateAsync(
      context,
      navigateTo: (context) => GuideViewPage(guideContentGuid: guide.guid),
    ),
  );
}

Widget draftGuideTilePresenter(
  BuildContext context,
  GuideDraftModel draftModel,
  AddGuideViewModel guide,
  String username,
  void Function() onDelete,
) {
  List<Widget> firstRow = [];
  firstRow.add(Row(
    children: [
      Icon(Icons.person),
      Text(username.isNotEmpty ? username : 'Please log in')
    ],
  ));
  if (guide.minutes > 0) {
    firstRow.add(Row(
      children: [
        Icon(Icons.timer),
        Text(getTranslations()
            .fromKey(LocaleKey.minutes)
            .replaceAll('{0}', guide.minutes.toString())),
      ],
    ));
  }
  Column child = Column(
    children: <Widget>[
      localImage(
        // guide.image == null
        getPath().defaultGuideImage,
      ),
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: firstRow,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4, right: 4, left: 4),
        child: Text(
          guide.title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: guide.tags
            .map((g) => genericChip(context, g, color: Colors.transparent))
            .toList(),
      ),
    ],
  );
  void Function() editFunc = () async => await getNavigation().navigateAsync(
        context,
        navigateTo: (context) => GuideAddEditPage(
          GuideContentViewModel.fromAddGuide(guide),
          guide.sections,
          draftModel: draftModel,
          isEdit: false,
        ),
      );
  return wrapInCommonCard(
    Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: iconBackgroundCover(
            context,
            popupMenu(
                  context,
                  iconColour: Colors.white,
                  onEdit: editFunc,
                  onDelete: onDelete,
                ) ??
                Container(),
            backgroundColour: getTheme().getCardBackgroundColour(context),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    ),
    onTap: editFunc,
  );
}
