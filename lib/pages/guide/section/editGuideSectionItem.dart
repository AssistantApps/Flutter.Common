import 'package:flutter/material.dart';

import '../../../components/adaptive/bottom_modal.dart';
import '../../../components/adaptive/button.dart';
import '../../../components/common/image.dart';
import '../../../components/common/placeholder.dart';
import '../../../components/forms/text_input.dart';
import '../../../contracts/enum/guide_section_item_type.dart';
import '../../../contracts/enum/locale_key.dart';
import '../../../contracts/generated/uploaded_image_view_model.dart';
import '../../../contracts/guide/guideSectionItem.dart';
import '../../../helpers/imageUploadHelper.dart';
import '../../../integration/dependencyInjection.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 8),
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
      IconButton(icon: const Icon(Icons.arrow_upward), onPressed: moveUp),
    );
  }
  if (moveDown != null) {
    widgets.add(
      IconButton(icon: const Icon(Icons.arrow_downward), onPressed: moveDown),
    );
  }
  if (onDelete != null) {
    widgets.add(
      IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
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
    padding: const EdgeInsets.symmetric(vertical: 8),
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
    padding: const EdgeInsets.symmetric(vertical: 8),
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

  const ImageEditItem(
    this.item,
    this.index,
    this.onChange,
    this.moveUp,
    this.moveDown,
    this.onDelete, {
    Key? key,
  }) : super(key: key);
  @override
  createState() => _ImageEditItemWidget();
}

class _ImageEditItemWidget extends State<ImageEditItem> {
  bool _imageUploading = false;
  UploadedImageViewModel? _imageData;

  @override
  Widget build(BuildContext context) {
    imageOnTap() {
      setState(() {
        _imageUploading = true;
      });
      adaptiveImageUploadToServer(
        (UploadedImageViewModel imageViewModel) {
          setState(() {
            _imageData = imageViewModel;
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
    UploadedImageViewModel? localImageData = _imageData;
    if ((localImageData != null &&
        localImageData.url.isNotEmpty &&
        localImageData.blurHash != null)) {
      imageWidget = NetworkBlurHashImage(
        imageUrl: localImageData.url,
        blurHash: localImageData.blurHash ?? '',
        onTap: imageOnTap,
        key: Key('${widget.item.guid}-sectionImage'),
      );
    }
    return Padding(
      key: Key('${widget.item.guid}-padding'),
      padding: const EdgeInsets.symmetric(vertical: 8),
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
                content: localImageData?.url,
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
    padding: const EdgeInsets.only(top: 8, bottom: 24),
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
        PositiveButton(
          title: getTranslations()
              .fromKey(LocaleKey.guideSectionAddMarkdownPreview),
          onTap: () {
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
  if (controllers.isEmpty) {
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
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Card(
      margin: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          children: rows,
          border: TableBorder.all(
            width: 1,
            color: getTheme().getH1Colour(context),
          ),
        ),
      ),
    ),
  );
}
