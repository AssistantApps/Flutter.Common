import 'package:intl/intl.dart';

String readStringSafe(Map<String, dynamic>? json, String prop) {
  if (json == null) return '';
  if (json[prop] == null) return '';
  try {
    return json[prop];
  } catch (ex) {
    return '';
  }
}

bool readBoolSafe(Map<dynamic, dynamic>? json, String prop) {
  if (json == null) return false;
  if (json[prop] == null) return false;
  try {
    return json[prop] as bool;
  } catch (ex) {
    return false;
  }
}

int readIntSafe(Map<dynamic, dynamic>? json, String prop,
    {int defaultValue = 0}) {
  if (json == null) return defaultValue;
  dynamic value = json[prop];
  if (value is int) return value;
  if (value == null) return defaultValue;
  try {
    return int.tryParse(json[prop]) ?? defaultValue;
  } catch (ex) {
    return 0;
  }
}

double readDoubleSafe(Map<dynamic, dynamic>? json, String prop,
    {double defaultValue = 0.0}) {
  if (json == null) return defaultValue;
  dynamic value = json[prop];
  if (value is double) return value;
  if (value == null) return defaultValue;
  try {
    return double.tryParse(json[prop]) ?? defaultValue;
  } catch (ex) {
    return 0.0;
  }
}

DateTime readDateSafe(Map<dynamic, dynamic>? json, String prop,
    {DateTime? defaultValue}) {
  if (json == null) return defaultValue ?? DateTime.now();
  try {
    return new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[prop], true);
  } catch (ex) {
    return defaultValue ?? DateTime.now();
  }
}

List<T> readListSafe<T>(
    Map<dynamic, dynamic>? json, String prop, T Function(dynamic) mapper) {
  if (json == null) return List.empty(growable: true);
  try {
    if (json[prop] == null) return List.empty(growable: true);
    return (json[prop] as List).map((item) => mapper(item)).toList();
  } catch (ex) {
    return List.empty(growable: true);
  }
}
