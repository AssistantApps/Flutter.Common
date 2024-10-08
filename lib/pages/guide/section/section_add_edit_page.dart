import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:uuid/uuid.dart';

import '../../../components/adaptive/bottom_modal.dart';
import '../../../components/adaptive/button.dart';
import '../../../components/common/space.dart';
import '../../../components/common/text.dart';
import '../../../components/forms/text_input.dart';
import '../../../components/grid/grid_with_scrollbar.dart';
import '../../../constants/padding_constant.dart';
import '../../../contracts/enum/guide_section_item_type.dart';
import '../../../contracts/enum/locale_key.dart';
import '../../../contracts/guide/guide_section.dart';
import '../../../contracts/guide/guide_section_item.dart';
import '../../../helpers/column_helper.dart';
import '../../../helpers/device_helper.dart';
import '../../../integration/dependency_injection.dart';
import './edit_guide_section_item.dart';
import './section_item_option.dart';

class SectionAddEditPage extends StatefulWidget {
  final bool isEdit;
  final GuideSection section;

  const SectionAddEditPage(
    this.section, {
    super.key,
    this.isEdit = false,
  });

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
          getNavigation().pop(innerContext);
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
          getNavigation().pop(context, _section);
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
        ResponsiveGridCol(
          lg: 12,
          md: 12,
          sm: 12,
          child: const EmptySpace1x(),
        ),
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
                child: GenericItemName(
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
          child: PositiveIconButton(
            icon: Icons.add,
            colour: getTheme().getSecondaryColour(context),
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

      griWidgets.add(ResponsiveGridCol(lg: 12, child: const EmptySpace8x()));
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
