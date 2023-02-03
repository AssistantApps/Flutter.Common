import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../contracts/misc/responsive_flex_data.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/columnHelper.dart';
import '../../integration/dependencyInjection.dart';
import './searchable_list.dart';

class ResponsiveListDetailView<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Widget? firstListItemWidget;
  final Widget Function(BuildContext context, T, int index,
      {void Function()? onTap}) listItemDisplayer;
  final void Function(BuildContext context, T)? listItemMobileOnTap;
  final Widget Function(
          BuildContext context, T, void Function(Widget) updateDetailView)?
      listItemDesktopOnTap;
  final bool Function(T, String) listItemSearch;
  final void Function()? deleteAll;
  final int minListForSearch;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;

  const ResponsiveListDetailView(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch, {
    Key? key,
    this.firstListItemWidget,
    this.listItemMobileOnTap,
    this.listItemDesktopOnTap,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
  }) : super(key: key);

  @override
  createState() => _ResponsiveListDetailWidget<T>();
}

class _ResponsiveListDetailWidget<T>
    extends State<ResponsiveListDetailView<T>> {
  Key detailViewKey = const Key('Initial');
  Widget detailView = Center(child: getLoading().smallLoadingIndicator());
  _ResponsiveListDetailWidget();

  void Function(BuildContext, T) getItemClickFunc(ResponsiveFlexData flexData) {
    return (flexData.isMobile && widget.listItemMobileOnTap != null)
        ? widget.listItemMobileOnTap!
        : alterDetailView;
  }

  void alterDetailView(BuildContext currentContext, T itemToView) {
    Widget newDetailWidget = widget.listItemDesktopOnTap!(
      currentContext,
      itemToView,
      updateDetailView,
    );
    updateDetailView(newDetailWidget);
  }

  void updateDetailView(Widget newDetailView) {
    setState(() {
      detailViewKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
      detailView = newDetailView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BreakpointBuilder(
      builder: (BuildContext innerContext, Breakpoint breakpoint) {
        ResponsiveFlexData flexData =
            getCustomListWithDetailsFlexWidth(breakpoint);

        Future<ResultWithValue<List<T>>> interceptedListGetter() async {
          ResultWithValue<List<T>> actualResult = await widget.listGetter();
          if (actualResult.isSuccess &&
              actualResult.value.isNotEmpty &&
              flexData.isMobile == false) {
            setState(() {
              detailViewKey =
                  Key(DateTime.now().millisecondsSinceEpoch.toString());
              detailView = widget.listItemDesktopOnTap!(
                innerContext,
                actualResult.value[0],
                updateDetailView,
              );
            });
          }
          return actualResult;
        }

        void Function(BuildContext, T) onTapFunc = getItemClickFunc(flexData);
        SearchableList<T> listView = SearchableList<T>(
          interceptedListGetter,
          listItemWithIndexDisplayer: (
            BuildContext innerC,
            T item,
            int index, {
            void Function()? onTap,
          }) =>
              widget.listItemDisplayer(innerC, item, index,
                  onTap: () => onTapFunc(innerC, item)),
          listItemSearch: widget.listItemSearch,
          key: widget.key,
          hintText: widget.hintText,
          deleteAll: widget.deleteAll,
          loadingText: widget.loadingText,
          minListForSearch: widget.minListForSearch,
          firstListItemWidget: widget.firstListItemWidget,
          addFabPadding: widget.addFabPadding,
        );
        if (flexData.isMobile) return listView;

        return Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              flex: flexData.flex1,
              child: listView,
            ),
            Flexible(
              key: detailViewKey,
              flex: flexData.flex2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        color: getTheme().getSecondaryColour(context),
                        width: 4),
                  ),
                ),
                child: detailView,
              ),
            ),
          ],
        );
      },
    );
  }
}
