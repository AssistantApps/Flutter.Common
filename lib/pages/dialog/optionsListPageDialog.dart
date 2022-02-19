import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';

class OptionsListPageDialog extends StatefulWidget {
  final String title;
  final int minListForSearch;
  final List<DropdownOption> options;
  final Widget Function(BuildContext, DropdownOption, int)? customPresenter;
  final void Function(DropdownOption)? addOption;
  final void Function(DropdownOption)? onDelete;

  OptionsListPageDialog(
    this.title,
    this.options, {
    this.minListForSearch = 10,
    this.customPresenter,
    this.addOption,
    this.onDelete,
  });

  @override
  _OptionsListPageDialogWidget createState() => _OptionsListPageDialogWidget();
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
        child: Icon(Icons.add),
        foregroundColor: getTheme().fabForegroundColourSelector(context),
        backgroundColor: getTheme().fabColourSelector(context),
      );
    }

    Widget Function(BuildContext p1, DropdownOption p2, int p3) presenter =
        widget.customPresenter ??
            (BuildContext innerC, DropdownOption option, int index) =>
                optionTilePresenter(innerC, option,
                    onDelete: (widget.onDelete != null)
                        ? () {
                            widget.onDelete!(option);
                            this.setState(() {
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
