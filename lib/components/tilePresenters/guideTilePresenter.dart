import 'package:assistantapps_flutter_common/constants/UIConstants.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/guide/addGuideViewModel.dart';
import '../../contracts/generated/guide/guideContentViewModel.dart';
import '../../contracts/generated/guide/guideSearchResultViewModel.dart';
import '../../contracts/guide/guideDraftModel.dart';
import '../../integration/dependencyInjection.dart';
import '../../pages/guide/guideAddEditPage.dart';
import '../../pages/guide/guideViewPage.dart';
import '../common/card.dart';
import '../common/icon.dart';
import '../common/image.dart';
import '../menu/popupMenu.dart';

Widget guideTilePresenter(
  BuildContext context,
  GuideSearchResultViewModel guide, {
  void Function()? onTap,
}) {
  // Widget imageWidget =
  //     (guide.imageUrl == null || guide.imageUrl.length < 5)
  //         ? LocalImage(imagePath: AppImage.error1, boxfit: BoxFit.fitWidth)
  //         : ImageFromNetwork(imageUrl:post.coverImageUrl, boxfit: BoxFit.fitWidth);
  Widget imageWidget = LocalImage(
    imagePath: getPath().defaultGuideImage,
    imagePackage: UIConstants.commonPackage,
  );

  List<Widget> firstRow = List.empty(growable: true);
  if (guide.showCreatedByUser && guide.userName.isNotEmpty) {
    firstRow.add(Row(
      children: [
        const Icon(Icons.person),
        Text(guide.userName),
      ],
    ));
  }
  if (guide.minutes > 0) {
    firstRow.add(Row(
      children: [
        const Icon(Icons.timer),
        Text(
          getTranslations()
              .fromKey(LocaleKey.minutes)
              .replaceAll('{0}', guide.minutes.toString()),
        ),
      ],
    ));
  }
  Column bodyWidget = Column(
    children: <Widget>[
      imageWidget,
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: firstRow,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 12, right: 4, left: 4),
        child: Text(
          guide.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: guide.tags
            .map((tag) => getBaseWidget().appChip(
                  text: tag,
                  backgroundColor: Colors.transparent,
                ))
            .toList(),
      ),
    ],
  );
  return WrapInCommonCard(
    child: bodyWidget,
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
      const Icon(Icons.person),
      Text(username.isNotEmpty ? username : 'Please log in')
    ],
  ));
  if (guide.minutes > 0) {
    firstRow.add(Row(
      children: [
        const Icon(Icons.timer),
        Text(getTranslations()
            .fromKey(LocaleKey.minutes)
            .replaceAll('{0}', guide.minutes.toString())),
      ],
    ));
  }
  Column child = Column(
    children: <Widget>[
      LocalImage(
        imagePath:
            // guide.image == null
            getPath().defaultGuideImage,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: firstRow,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
        child: Text(
          guide.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.center,
        children: guide.tags //
            .map((g) => getBaseWidget().appChip(
                  text: g,
                  backgroundColor: Colors.transparent,
                ))
            .toList(),
      ),
    ],
  );
  editFunc() async => await getNavigation().navigateAsync(
        context,
        navigateTo: (context) => GuideAddEditPage(
          GuideContentViewModel.fromAddGuide(guide),
          guide.sections,
          draftModel: draftModel,
          isEdit: false,
        ),
      );
  return WrapInCommonCard(
    onTap: editFunc,
    child: Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: IconBackgroundCover(
            backgroundColour: getTheme().getCardBackgroundColour(context),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
            child: popupMenu(
                  context,
                  iconColour: Colors.white,
                  onEdit: editFunc,
                  onDelete: onDelete,
                ) ??
                Container(),
          ),
        ),
      ],
    ),
  );
}
