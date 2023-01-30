import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AdaptiveDropdown extends StatefulWidget {
  final List<DropdownOption> options;
  final String? initialValue;
  final Icon? icon;
  final BorderRadius? borderRadius;
  final void Function(String value) onChanged;

  const AdaptiveDropdown({
    Key? key,
    required this.options,
    required this.onChanged,
    this.initialValue,
    this.icon,
    this.borderRadius,
  }) : super(key: key);

  @override
  createState() => _AdaptiveDropdownState();
}

class _AdaptiveDropdownState extends State<AdaptiveDropdown> {
  String? currentValue;

  @override
  initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        widget.borderRadius ?? UIConstants.generalBorderRadius;
    var primaryColour = getTheme().getPrimaryColour(context);
    var backgroundColour = getTheme().getBackgroundColour(context);
    //
    var items = widget.options
        .map(
          (item) => DropdownMenuItem<String>(
            value: item.value,
            child: Text(item.title, overflow: TextOverflow.ellipsis),
          ),
        )
        .toList();
    //
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(Icons.list, size: 32),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Select Item',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items,
        value: currentValue,
        icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
        iconSize: 32,
        buttonPadding: const EdgeInsets.only(right: 8),
        buttonDecoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: darken(primaryColour, 0.25)),
          color: backgroundColour,
        ),
        dropdownDecoration: BoxDecoration(borderRadius: borderRadius),
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        //
        onChanged: (value) {
          if (value == null) return;
          if ((value is String) == false) return;

          String result = value as String;
          widget.onChanged(result);
          setState(() {
            currentValue = result;
          });
        },
      ),
    );
  }
}
