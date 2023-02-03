import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_grid/responsive_grid.dart';
import 'package:uuid/uuid.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../assistantapps_flutter_common.dart';
import '../../components/common/placeholder.dart';
import '../../constants/app_image.dart';
import '../../contracts/generated/uploaded_image_view_model.dart';
import '../../contracts/mapper/guide_section_mapper.dart';
import '../../helpers/imageUploadHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../../validation/commonValidator.dart';

class GuideAddEditPage extends StatefulWidget {
  final String? analyticsKey;
  final bool isEdit;
  final GuideDraftModel draftModel;
  final GuideContentViewModel _guideDetails;
  final List<GuideSectionViewModel> sections;

  GuideAddEditPage(
    this._guideDetails,
    this.sections, {
    Key? key,
    this.analyticsKey,
    this.isEdit = false,
    required this.draftModel,
  }) : super(key: key) {
    if (analyticsKey != null) {
      getAnalytics().trackEvent(analyticsKey!);
    }
  }
  @override
  // ignore: no_logic_in_create_state
  createState() => _GuideAddEditWidget(
        _guideDetails,
        sections,
      );
}

class _GuideAddEditWidget extends State<GuideAddEditPage> {
  GuideContentViewModel _guideDetails;
  late UploadedImageViewModel? bannerImageData;
  final List<GuideSectionViewModel> sections;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subTitleController = TextEditingController();
  TextEditingController _minutesController = TextEditingController();
  List<String> tags = List.empty(growable: true);
  late Map<LocaleKey, List<LocaleKey> Function()> _validationMap;
  bool _showValidation = false;
  bool _isLoading = false;
  bool _imageUploading = false;

  _GuideAddEditWidget(this._guideDetails, this.sections) {
    _titleController = TextEditingController(text: _guideDetails.title);
    _subTitleController = TextEditingController(text: _guideDetails.subTitle);
    _minutesController =
        TextEditingController(text: _guideDetails.minutes.toString());
    tags = _guideDetails.tags;
    bannerImageData = UploadedImageViewModel(url: AppImage.onlinePatreonIcon);
    //
    _validationMap = {
      LocaleKey.guideName: () =>
          nameValidator(_titleController.text, minLength: 1, maxLength: 50),
      LocaleKey.guideSubTitle: () => nameValidator(_subTitleController.text,
          minLength: 10, maxLength: 100),
      LocaleKey.guideMinutes: () =>
          numberValidator(_minutesController.text, min: 0, max: 1000),
      LocaleKey.guideTags: () => noValidator(),
    };
  }

  updateDetailsObj(GuideDraftModel reduxViewModel, {bool? showCreatedByUser}) {
    setState(() {
      bool showByUser = showCreatedByUser ?? _guideDetails.showCreatedByUser;
      _guideDetails = _guideDetails.copyWith(
        title: _titleController.text,
        subTitle: _subTitleController.text,
        languageCode: reduxViewModel.selectedLanguage,
        showCreatedByUser: showByUser,
        minutes: int.tryParse(_minutesController.text) ?? 0,
        tags: tags,
      );
    });
    reduxViewModel.updateGuide(AddGuideViewModel.fromGuideDetails(
      _guideDetails,
      sections: sections,
      appGuid: getEnv().assistantAppsAppGuid,
    ));
  }

  fabOnPressed(GuideDraftModel reduxViewModel) async {
    if (!_allValidationsPassed()) {
      setState(() {
        _showValidation = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (widget.isEdit) {
      // Send full object to API
    } else {
      AddGuideViewModel apiAdObj = AddGuideViewModel.fromGuideDetails(
        _guideDetails,
        sections: sections,
        appGuid: getEnv().assistantAppsAppGuid,
      );
      Result addResult = await getAssistantAppsGuide().addGuide(apiAdObj);
      setState(() {
        _isLoading = false;
      });
      if (addResult.hasFailed) {
        // ignore: use_build_context_synchronously
        getDialog().showSimpleDialog(
          context,
          getTranslations().fromKey(LocaleKey.guideSubmissionFailedTitle),
          Column(
            children: [
              const LocalImage(
                imagePath: AppImage.error,
                imagePackage: UIConstants.commonPackage,
              ),
              GenericItemDescription(
                getTranslations()
                    .fromKey(LocaleKey.guideSubmissionFailedMessage),
              ),
            ],
          ),
          buttonBuilder: (BuildContext btnContext) {
            return [
              getDialog().simpleDialogCloseButton(
                context,
                onTap: () => getNavigation().pop(btnContext),
              ),
            ];
          },
        );
      } else {
        reduxViewModel.deleteGuide(_guideDetails.guid);
        // ignore: use_build_context_synchronously
        getDialog().showSimpleDialog(
          context,
          getTranslations().fromKey(LocaleKey.guideSubmissionSuccessTitle),
          Column(
            children: [
              WebsafeSvg.asset(
                AppImage.successGuideSVG,
                package: UIConstants.commonPackage,
              ),
              GenericItemDescription(
                getTranslations()
                    .fromKey(LocaleKey.guideSubmissionSuccessMessage),
              ),
            ],
          ),
          buttonBuilder: (BuildContext btnContext) {
            return [
              getDialog().simpleDialogCloseButton(
                context,
                onTap: () => getNavigation().pop(btnContext),
              ),
            ];
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(getTranslations().fromKey(LocaleKey.guides)),
      ),
      body: getBody(widget.draftModel),
      floatingActionButton: FloatingActionButton(
        heroTag: 'AddEditGuide',
        backgroundColor: getTheme().fabColourSelector(context),
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        onPressed: () => fabOnPressed(widget.draftModel),
        child: const Icon(Icons.file_upload),
      ),
    );
  }

  Widget getBody(GuideDraftModel reduxViewModel) {
    if (_isLoading) return getLoading().fullPageLoading(context);

    return BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
      List<ResponsiveGridCol> griWidgets = List.empty(growable: true);
      bool isMobile = isMobileScreenWidth(breakpoint);

      formFieldOnChange(_) => updateDetailsObj(reduxViewModel);

      imageOnTap() {
        setState(() {
          _imageUploading = true;
        });
        adaptiveImageUploadToServer(
          (UploadedImageViewModel imageViewModel) {
            setState(() {
              bannerImageData = imageViewModel;
              _imageUploading = false;
            });
          },
          (_) {
            // Failed
            setState(() {
              _imageUploading = false;
            });
          },
        );
      }

      Widget imageWidget = PlaceholderImage(onTap: imageOnTap);
      if ((bannerImageData != null &&
          bannerImageData?.url != null &&
          bannerImageData?.blurHash != null)) {
        imageWidget = NetworkBlurHashImage(
          imageUrl: bannerImageData!.url,
          blurHash: bannerImageData!.blurHash ?? '',
          onTap: imageOnTap,
          key: const Key('BannerImage'),
        );
      }

      griWidgets.add(ResponsiveGridCol(
        lg: 12,
        md: 12,
        sm: 12,
        child: Center(
          child: _imageUploading
              ? getLoading().smallLoadingIndicator()
              : imageWidget,
        ),
      ));

      griWidgets.add(ResponsiveGridCol(
        xl: 3,
        lg: 4,
        md: 6,
        sm: 12,
        xs: 12,
        child: formTextInput(
          innerContext,
          _titleController,
          LocaleKey.guideName,
          validator: _validationMap[LocaleKey.guideName],
          showValidation: _showValidation,
          onChange: formFieldOnChange,
        ),
      ));

      griWidgets.add(ResponsiveGridCol(
        xl: 3,
        lg: 8,
        md: 6,
        sm: 12,
        xs: 12,
        child: formTextInput(
          innerContext,
          _subTitleController,
          LocaleKey.guideSubTitle,
          validator: _validationMap[LocaleKey.guideSubTitle],
          showValidation: _showValidation,
          onChange: formFieldOnChange,
        ),
      ));

      griWidgets.add(ResponsiveGridCol(
        xl: 3,
        lg: 3,
        md: 6,
        sm: 12,
        xs: 12,
        child: formNumberInput(
          innerContext,
          _minutesController,
          LocaleKey.guideMinutes,
          validator: _validationMap[LocaleKey.guideMinutes],
          showValidation: _showValidation,
          onChange: formFieldOnChange,
        ),
      ));

      griWidgets.add(ResponsiveGridCol(
        xl: 3,
        lg: 4,
        md: 6,
        sm: 12,
        xs: 12,
        child: formBoolInput(
          innerContext,
          _guideDetails.showCreatedByUser,
          LocaleKey.showCreatedBy,
          isMobile: isMobile,
          onChange: (bool newValue) => updateDetailsObj(
            reduxViewModel,
            showCreatedByUser: newValue,
          ),
        ),
      ));

      griWidgets.add(
        ResponsiveGridCol(
          lg: 12,
          md: 12,
          sm: 12,
          child: Padding(
            padding: textEditingPadding,
            child: ChipTags(
              list: tags,
              separator: ' ',
              chipColor: getTheme().getSecondaryColour(innerContext),
              iconColor: Colors.white,
              textColor: Colors.white,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: getTranslations().fromKey(LocaleKey.guideTags),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: getTheme().getPrimaryColour(innerContext),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      );

      List<Widget> stickyWidgets = List.empty(growable: true);
      for (var sectionIndex = 0;
          sectionIndex < sections.length;
          sectionIndex++) {
        GuideSectionViewModel section = sections[sectionIndex];
        List<Widget> sectionItemWidgets = List.empty(growable: true);
        for (GuideSectionItemViewModel sectionItem in section.items) {
          var sectionItemItemWidget = getSectionItem(context, sectionItem);
          if (sectionItemItemWidget != null) {
            sectionItemWidgets.add(sectionItemItemWidget);
          }
        }
        stickyWidgets.add(
          sectionListItem(
            context,
            section.heading,
            sectionItemWidgets,
            moveUp: (sectionIndex <= 0)
                ? null
                : () {
                    setState(() {
                      var itemToMove = sections.removeAt(sectionIndex);
                      sections.insert(sectionIndex - 1, itemToMove);
                    });
                    updateDetailsObj(reduxViewModel);
                  },
            moveDown: (sectionIndex >= (sections.length - 1))
                ? null
                : () {
                    setState(() {
                      var itemToMove = sections.removeAt(sectionIndex);
                      sections.insert(sectionIndex + 1, itemToMove);
                    });
                    updateDetailsObj(reduxViewModel);
                  },
            onEdit: () async {
              GuideSection? result =
                  await getNavigation().navigateAsync<GuideSection>(
                context,
                navigateTo: (context) => SectionAddEditPage(section.toDomain()),
              );
              if (result == null) return;
              setState(() {
                sections[sectionIndex] = result.toViewModel();
              });
              updateDetailsObj(reduxViewModel);
            },
            onDelete: () {
              setState(() {
                sections.removeAt(sectionIndex);
              });
              updateDetailsObj(reduxViewModel);
            },
          ),
        );
      }

      List<Widget> sectionStickyWidgets = [
        PlaceholderFullRow(
          icon: Icons.add_box,
          onTap: () async {
            GuideSection? result =
                await getNavigation().navigateAsync<GuideSection>(
              context,
              navigateTo: (context) => SectionAddEditPage(GuideSection(
                guid: const Uuid().v1(),
                heading: '',
                headingTextController: TextEditingController(text: ''),
                items: List.empty(),
                sortOrder: sections.length + 1,
              )),
            );
            if (result == null) return;
            setState(() {
              sections.add(result.toViewModel());
            });
          },
        ),
        const EmptySpace10x(),
      ];

      stickyWidgets.add(SliverStickyHeader(
        header: (stickyWidgets.isEmpty)
            ? sectionHeadingItem(
                context,
                getTranslations().fromKey(LocaleKey.guideSectionsAdd),
              )
            : const SizedBox(width: 0, height: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) => sectionStickyWidgets[i],
            childCount: sectionStickyWidgets.length,
          ),
        ),
      ));

      List<Widget> stickyGuideDetailsWidgets = [
        ResponsiveGridRow(children: griWidgets),
        customDivider(),
        const EmptySpace1x(),
      ];
      return CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverStickyHeader(
            header: const SizedBox(height: 0, width: 0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) => stickyGuideDetailsWidgets[i],
                childCount: stickyGuideDetailsWidgets.length,
              ),
            ),
          ),
          ...stickyWidgets,
        ],
      );
    });
  }

  List<LocaleKey> Function() getValidator(LocaleKey validationKey) {
    return _validationMap[validationKey] ?? () => List.empty();
  }

  bool _allValidationsPassed() {
    for (var validationKey in _validationMap.keys) {
      List<LocaleKey> Function() validate = getValidator(validationKey);
      List<LocaleKey> vResult = validate();
      if (vResult.isNotEmpty) return false;
    }
    return true;
  }
}
