import 'package:flutter/material.dart';

class DropdownOption {
  String title;
  late String value;
  String? icon;

  DropdownOption(this.title, {this.icon, String? value}) {
    this.value = value ?? this.title;
  }

  DropdownMenuItem<String> toDropdownMenuItem() {
    return DropdownMenuItem<String>(
      child: Text(this.title),
      value: this.value,
    );
  }
}
