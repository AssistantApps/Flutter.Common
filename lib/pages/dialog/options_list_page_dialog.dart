import 'package:flutter/material.dart';

import '../../components/list/searchable_list.dart';
import '../../components/tilePresenters/option_tile_presenter.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/search/dropdown_option.dart';
import '../../helpers/search_list_helper.dart';
import '../../integration/dependency_injection_base.dart';

class OptionsListPageDialog extends StatefulWidget {
  final String title;
  final int minListForSearch;
  final List<DropdownOption> options;
  final Widget Function(BuildContext, DropdownOption, int,
      {void Function()? onTap})? customPresenter;
  final void Function(DropdownOption)? addOption;
  final void Function(DropdownOption)? onDelete;

  const OptionsListPageDialog(
    this.title,
    this.options, {
    Key? key,
    this.minListForSearch = 10,
    this.customPresenter,
    this.addOption,
    this.onDelete,
  }) : super(key: key);

  @override
  createState() => _OptionsListPageDialogWidget();
}

class _OptionsListPageDialogWidget extends State<OptionsListPageDialog> {
  @override
  Widget build(BuildContext context) {
    Widget? floatingActionButtonWidget;

    if (widget.addOption != null) {
      floatingActionButtonWidget = FloatingActionButton(
        onPressed: () async {
          String temp = await getDialog().asyncInputDialog(
              context, getTranslations().fromKey(LocaleKey.addTag));
          if (temp == '' ||
              temp == ' ' ||
              widget.options.any((opt) => opt.value == temp)) {
            return;
          }
          DropdownOption option = DropdownOption(temp);
          widget.addOption!(option);
          setState(() {
            widget.options.add(option);
          });
        },
        heroTag: 'OptionsListPageDialog',
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        backgroundColor: getTheme().fabColourSelector(context),
        child: const Icon(Icons.add),
      );
    }

    Widget Function(BuildContext p1,
            DropdownOption p2, int p3, {void Function()? onTap}) presenter =
        widget.customPresenter ??
            (BuildContext innerC, DropdownOption option, int index,
                    {void Function()? onTap}) =>
                optionTilePresenter(innerC, option,
                    onDelete: (widget.onDelete != null)
                        ? () {
                            widget.onDelete!(option);
                            setState(() {
                              widget.options.remove(option);
                            });
                          }
                        : null);

    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(widget.title),
      ),
      body: SearchableList<DropdownOption>(
        getSearchListFutureFromList(widget.options),
        listItemWithIndexDisplayer: presenter,
        listItemSearch: (DropdownOption option, String search) =>
            option.title.toLowerCase().contains(search),
        minListForSearch: widget.minListForSearch,
        key: Key('num Items: ${widget.options.length.toString()}'),
      ),
      floatingActionButton: floatingActionButtonWidget,
    );
  }
}
