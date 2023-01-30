import 'package:flutter/material.dart';

class DropdownOption {
  String title;
  late String value;
  String? icon;

  DropdownOption(this.title, {this.icon, String? value}) {
    this.value = value ?? title;
  }

  DropdownMenuItem<String> toDropdownMenuItem() {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(title),
    );
  }
}
