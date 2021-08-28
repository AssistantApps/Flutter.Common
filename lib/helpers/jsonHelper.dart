import 'package:intl/intl.dart';

String readStringSafe(Map<String, dynamic> json, String prop) {
  if (json == null) return '';
  if (json[prop] == null) return '';
  return json[prop];
}

bool readBoolSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return false;
  if (json[prop] == null) return false;
  return json[prop] as bool;
}

int readIntSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0;
  dynamic value = json[prop];
  if (value is int) return value;
  if (value == null) return 0;
  return int.tryParse(json[prop]);
}

double readDoubleSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0.0;
  dynamic value = json[prop];
  if (value is double) return value;
  if (value == null) return 0.0;
  return double.tryParse(json[prop]);
}

DateTime readDateSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return null;
  try {
    var value = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[prop], true);
    return (value == null) ? null : value;
  } catch (ex) {
    return null;
  }
}

List<T> readListSafe<T>(
    Map<dynamic, dynamic> json, String prop, T Function(dynamic) mapper) {
  if (json == null) return List.empty(growable: true);
  if (json[prop] == null) return List.empty(growable: true);
  return (json[prop] as List).map((item) => mapper(item)).toList();
}
