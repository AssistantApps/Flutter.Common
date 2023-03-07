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
        hint: const Row(
          children: [
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
        iconStyleData: IconStyleData(
          icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
          iconSize: 32,
        ),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: darken(primaryColour, 0.25)),
            color: backgroundColour,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: borderRadius),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.resolveWith((_) => 6.0),
            )),
        //
        onChanged: (String? value) {
          if (value == null) return;

          widget.onChanged(value);
          setState(() {
            currentValue = value;
          });
        },
      ),
    );
  }
}
