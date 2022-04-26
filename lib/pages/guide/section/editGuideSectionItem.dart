import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../../components/common/placeholder.dart';
import '../../../components/forms/textInput.dart';
import '../../../contracts/enum/guideSectionItemType.dart';
import '../../../contracts/generated/uploadedImageViewModel.dart';
import '../../../contracts/guide/guideSectionItem.dart';
import '../../../helpers/imageUploadHelper.dart';
import '../../misc/markdownPreviewPage.dart';

Widget getSectionEditItem(BuildContext context, GuideSectionItem item,
    int index, Function(GuideSectionItem) onChange,
    {void Function()? onDelete,
    void Function()? moveUp,
    void Function()? moveDown}) {
  switch (item.type) {
    case GuideSectionItemType.text:
      return textEditItem(
          context, item, index, onChange, moveUp, moveDown, onDelete);
    case GuideSectionItemType.link:
      return linkEditItem(
          context, item, index, onChange, moveUp, moveDown, onDelete);
    case GuideSectionItemType.image:
      return ImageEditItem(item, index, onChange, moveUp, moveDown, onDelete);
    case GuideSectionItemType.markdown:
      return markdownEditItem(
          context, item, index, onChange, moveUp, moveDown, onDelete);
    case GuideSectionItemType.table:
      return tableEditItem(context, item, index, onChange);
    default:
      return Padding(
        key: Key('${item.guid}-padding'),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(),
      );
  }
}

Widget getSectionItemHeading(int index, List<Widget> actions) {
  return Stack(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions,
      ),
      Positioned.fill(
        child: Center(child: Text('Item ${(index + 1).toString()}')),
      ),
    ],
  );
}

List<Widget> getActions(
  void Function()? moveUp,
  void Function()? moveDown,
  void Function()? onDelete,
) {
  List<Widget> widgets = List.empty(growable: true);
  if (moveUp != null) {
    widgets.add(
      IconButton(icon: Icon(Icons.arrow_upward), onPressed: moveUp),
    );
  }
  if (moveDown != null) {
    widgets.add(
      IconButton(icon: Icon(Icons.arrow_downward), onPressed: moveDown),
    );
  }
  if (onDelete != null) {
    widgets.add(
      IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
    );
  }
  return widgets;
}

Widget textEditItem(
    BuildContext context,
    GuideSectionItem item,
    int index,
    void Function(GuideSectionItem) onChange,
    void Function()? moveUp,
    void Function()? moveDown,
    void Function()? onDelete) {
  return Padding(
    key: Key('${item.guid}-padding'),
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      key: Key('${item.guid}-column'),
      children: [
        getSectionItemHeading(index, getActions(moveUp, moveDown, onDelete)),
        formTextInput(
          context,
          item.contentTextController,
          LocaleKey.guideSectionAddText,
          baseKey: '${item.guid}-formTextInput',
          isMultiline: true,
          maxLines: 10,
          onChange: (String newValue) {
            onChange(item.copyWith(
              content: newValue,
            ));
          },
        ),
      ],
    ),
  );
}

Widget linkEditItem(
    BuildContext context,
    GuideSectionItem item,
    int index,
    Function(GuideSectionItem) onChange,
    void Function()? moveUp,
    void Function()? moveDown,
    void Function()? onDelete) {
  return Padding(
    key: Key('${item.guid}-padding'),
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        getSectionItemHeading(index, getActions(moveUp, moveDown, onDelete)),
        formTextInput(
          context,
          item.additionalContentTextController,
          LocaleKey.guideSectionAddLinkName,
          onChange: (String newValue) {
            onChange(item.copyWith(
              additionalContent: newValue,
            ));
          },
        ),
        formTextInput(
          context,
          item.contentTextController,
          LocaleKey.guideSectionAddLinkAddress,
          onChange: (String newValue) {
            onChange(item.copyWith(
              content: newValue,
            ));
          },
        ),
      ],
    ),
  );
}

class ImageEditItem extends StatefulWidget {
  final GuideSectionItem item;
  final int index;
  final Function(GuideSectionItem) onChange;
  final void Function()? moveUp;
  final void Function()? moveDown;
  final void Function()? onDelete;
  ImageEditItem(this.item, this.index, this.onChange, this.moveUp,
      this.moveDown, this.onDelete);
  @override
  _ImageEditItemWidget createState() => _ImageEditItemWidget();
}

class _ImageEditItemWidget extends State<ImageEditItem> {
  bool _imageUploading = false;
  late UploadedImageViewModel? _imageData;

  _ImageEditItemWidget() {
    _imageData = UploadedImageViewModel(url: widget.item.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    var imageOnTap = () {
      this.setState(() {
        _imageUploading = true;
      });
      adaptiveImageUploadToServer(
        (UploadedImageViewModel imageViewModel) {
          this.setState(() {
            _imageData = imageViewModel;
            _imageUploading = false;
          });
        },
        () {
          // Failed
          this.setState(() {
            _imageUploading = false;
          });
        },
      );
    };

    var imageWidget = placeholderImage(context, onTap: imageOnTap);
    if ((_imageData != null &&
        _imageData?.url != null &&
        _imageData?.blurHash != null)) {
      imageWidget = networkBlurHashImage(
        _imageData!.url,
        _imageData!.blurHash ?? '',
        onTap: imageOnTap,
        key: Key('${widget.item.guid}-sectionImage'),
      );
    }
    return Padding(
      key: Key('${widget.item.guid}-padding'),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          getSectionItemHeading(
            widget.index,
            getActions(widget.moveUp, widget.moveDown, widget.onDelete),
          ),
          _imageUploading ? getLoading().smallLoadingIndicator() : imageWidget,
          formTextInput(
            context,
            widget.item.contentTextController,
            LocaleKey.guideSectionAddImageCaption,
            onChange: (String newValue) {
              widget.onChange(widget.item.copyWith(
                content: _imageData?.url,
                additionalContent: newValue,
              ));
            },
          ),
        ],
      ),
    );
  }
}

Widget markdownEditItem(
    BuildContext context,
    GuideSectionItem item,
    int index,
    Function(GuideSectionItem) onChange,
    void Function()? moveUp,
    void Function()? moveDown,
    void Function()? onDelete) {
  return Padding(
    key: Key('${item.guid}-padding'),
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        getSectionItemHeading(index, getActions(moveUp, moveDown, onDelete)),
        formTextInput(
          context,
          item.contentTextController,
          LocaleKey.guideSectionAddMarkdownContent,
          isMultiline: true,
          onChange: (String newValue) {
            onChange(item.copyWith(
              content: newValue,
            ));
          },
        ),
        positiveButton(
          context,
          title: getTranslations()
              .fromKey(LocaleKey.guideSectionAddMarkdownPreview),
          onPress: () {
            adaptiveBottomModalSheet(
              context,
              builder: (context) => MarkdownPreviewPage(
                item.contentTextController.text,
                showAppBar: false,
              ),
            );
          },
        )
      ],
    ),
  );
}

Widget tableEditItem(BuildContext context, GuideSectionItem item, int index,
    Function(GuideSectionItem) onChange) {
  List<TextEditingController> controllers =
      item.tableColumnNameTextController ?? List.empty(growable: true);
  if (controllers.length < 1) {
    controllers.add(TextEditingController());
    controllers.add(TextEditingController());
  }

  List<Widget> headingRowChildren = List.empty(growable: true);
  for (var headIndex = 0; headIndex < controllers.length; headIndex++) {
    headingRowChildren.add(formTextInput(
      context,
      controllers[headIndex],
      LocaleKey.about,
      baseKey: '${item.guid}-headingInput-$headIndex',
      isMultiline: true,
      maxLines: 10,
      onChange: (String newValue) {
        // onChange(GuideSectionItem(
        //   guid: item.guid,
        //   type: item.type,
        //   content: newValue,
        //   contentTextController: item.contentTextController,
        // ));
      },
    ));
  }

  List<TableRow> rows = List.empty(growable: true);
  rows.add(TableRow(children: headingRowChildren));

  // for (var row in item.tableDataTextController) {
  //   var rowChildren = List<Widget>();
  //   for (var colIndex = 0; colIndex < row.length; colIndex++) {
  //     rowChildren.add(Padding(
  //       child: formTextInput(
  //         context,
  //         row[colIndex],
  //         LocaleKey.about,
  //         baseKey: '${item.guid}-rowInput',
  //         isMultiline: true,
  //         maxLines: 10,
  //         onChange: (String newValue) {
  //           // onChange(GuideSectionItem(
  //           //   guid: item.guid,
  //           //   type: item.type,
  //           //   content: newValue,
  //           //   contentTextController: item.contentTextController,
  //           // ));
  //         },
  //       ),
  //       padding: const EdgeInsets.all(8.0),
  //     ));
  //   }
  //   rows.add(TableRow(children: rowChildren));
  // }

  return Padding(
    key: Key('${item.guid}-padding'),
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Card(
      child: Padding(
        child: Table(
          children: rows,
          border:
              TableBorder.all(width: 1, color: getTheme().getH1Colour(context)),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      margin: const EdgeInsets.all(0.0),
    ),
  );
}
