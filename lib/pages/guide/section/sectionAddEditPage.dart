import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:uuid/uuid.dart';

import '../../../components/adaptive/bottomModal.dart';
import '../../../components/adaptive/button.dart';
import '../../../components/common/space.dart';
import '../../../components/common/text.dart';
import '../../../components/forms/textInput.dart';
import '../../../components/grid/gridWithScrollbar.dart';
import '../../../constants/PaddingConstant.dart';
import '../../../contracts/enum/guideSectionItemType.dart';
import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/guide/guideSection.dart';
import '../../../contracts/guide/guideSectionItem.dart';
import '../../../helpers/columnHelper.dart';
import '../../../helpers/deviceHelper.dart';
import '../../../integration/dependencyInjection.dart';
import './editGuideSectionItem.dart';
import './sectionItemOption.dart';

class SectionAddEditPage extends StatefulWidget {
  final bool isEdit;
  final GuideSection section;

  const SectionAddEditPage(
    this.section, {
    Key? key,
    this.isEdit = false,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  createState() => _SectionAddEditWidget(section);
}

class _SectionAddEditWidget extends State<SectionAddEditPage> {
  final GuideSection _section;
  Widget _optionsMenu = Container();
  //
  final Map<LocaleKey, List<LocaleKey> Function()> _validationMap = {
    // LocaleKey.guideName: () =>
    //     nameValidator(_titleController.text, minLength: 1, maxLength: 50),
    // LocaleKey.guideSubTitle: () => nameValidator(_subTitleController.text,
    //     minLength: 10, maxLength: 100),
    // LocaleKey.guideMinutes: () =>
    //     numberValidator(_minutesController.text, min: 0, max: 1000),
    // LocaleKey.guideTags: () => noValidator(),
  };
  bool _showValidation = false;

  _SectionAddEditWidget(this._section) {
    _optionsMenu = gridWithScrollbar(
      gridViewColumnCalculator: sectionItemCustomColumnCount,
      itemCount: availableSectionTypes.length,
      itemBuilder: (BuildContext innerContext, int index) =>
          sectionItemOptionTilePresenter(
        innerContext,
        availableSectionTypes[index],
        (GuideSectionItemType type) {
          setState(() {
            if (_section.items.isEmpty) {
              _section.items = List.empty(growable: true);
            }
            _section.items.add(GuideSectionItem(
              guid: const Uuid().v1(),
              type: type,
              sortOrder: _section.items.length + 1,
              contentTextController: TextEditingController(),
              additionalContentTextController: TextEditingController(),
            ));
          });
          Navigator.of(innerContext).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.guides)),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'AddEditSection',
        backgroundColor: getTheme().fabColourSelector(context),
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        child: const Icon(Icons.check),
        onPressed: () {
          if (!_allValidationsPassed()) {
            setState(() {
              _showValidation = true;
            });
            return;
          }
          Navigator.of(context).pop(_section);
        },
      ),
    );
  }

  Widget getBody() {
    return BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
      List<ResponsiveGridCol> griWidgets = List.empty(growable: true);
      // bool isMobile = isMobileScreenWidth(breakpoint);

      griWidgets.add(
        ResponsiveGridCol(lg: 12, md: 12, sm: 12, child: emptySpace1x()),
      );
      griWidgets.add(ResponsiveGridCol(
        xl: 3,
        lg: 4,
        md: 6,
        sm: 12,
        xs: 12,
        child: formTextInput(
          innerContext,
          _section.headingTextController,
          LocaleKey.guideSectionHeading,
          validator: getValidator(LocaleKey.guideSectionHeading),
          showValidation: _showValidation,
          onChange: (String newValue) {
            setState(() {
              _section.heading = newValue;
            });
          },
        ),
      ));

      if (_section.items.isEmpty) {
        griWidgets.add(ResponsiveGridCol(
          lg: 12,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
                child: genericItemName(
              getTranslations().fromKey(LocaleKey.noItems),
            )),
          ),
        ));
      } else {
        for (int itemIndex = 0;
            itemIndex < _section.items.length;
            itemIndex++) {
          griWidgets.add(ResponsiveGridCol(lg: 12, child: customDivider()));
          griWidgets.add(ResponsiveGridCol(
            lg: 12,
            child: getSectionEditItem(
              context,
              _section.items[itemIndex],
              itemIndex,
              (GuideSectionItem newValue) {
                setState(() {
                  _section.items[itemIndex] = newValue;
                });
              },
              onDelete: () {
                setState(() {
                  _section.items.removeAt(itemIndex);
                });
              },
              moveUp: (itemIndex <= 0)
                  ? null
                  : () {
                      setState(() {
                        var itemToMove = _section.items.removeAt(itemIndex);
                        _section.items.insert(itemIndex - 1, itemToMove);
                      });
                    },
              moveDown: (itemIndex >= (_section.items.length - 1))
                  ? null
                  : () {
                      setState(() {
                        var itemToMove = _section.items.removeAt(itemIndex);
                        _section.items.insert(itemIndex + 1, itemToMove);
                      });
                    },
            ),
          ));
        }
      }

      griWidgets.add(ResponsiveGridCol(
        lg: 12,
        child: Padding(
          padding: PaddingConstant.listViewPadding,
          child: positiveIconButton(
            getTheme().getSecondaryColour(context),
            icon: Icons.add,
            padding: const EdgeInsets.all(8),
            onPress: () {
              adaptiveBottomModalSheet(
                context,
                builder: (context) => _optionsMenu,
              );
            },
          ),
        ),
      ));

      griWidgets.add(ResponsiveGridCol(lg: 12, child: emptySpace8x()));
      return SingleChildScrollView(
        child: ResponsiveGridRow(children: griWidgets),
      );
    });
  }

  List<LocaleKey> Function() getValidator(LocaleKey validationKey) {
    return _validationMap[validationKey] ?? () => List.empty();
  }

  bool _allValidationsPassed() {
    for (LocaleKey validationKey in _validationMap.keys) {
      List<LocaleKey> Function() validate = getValidator(validationKey);
      List<LocaleKey> vResult = validate();
      if (vResult.isNotEmpty) return false;
    }
    return true;
  }
}
