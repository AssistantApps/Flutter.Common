import 'package:intl/intl.dart';

String readStringSafe(Map<String, dynamic> json, String prop) =>
    (json[prop] == null) ? null : json[prop];

bool readBoolSafe(Map<dynamic, dynamic> json, String prop) =>
    (json[prop] == null) ? false : json[prop] as bool;

int readIntSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0;
  dynamic value = json[prop];
  if (value is int) return value;
  return (value == null) ? 0 : int.tryParse(json[prop]);
}

double readDoubleSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return 0.0;
  dynamic value = json[prop];
  if (value is double) return value;
  return (value == null) ? 0.0 : double.tryParse(json[prop]);
}

DateTime readDateSafe(Map<dynamic, dynamic> json, String prop) {
  if (json == null) return null;
  try {
    var value = new DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json[prop], true);
    return (value == null) ? null : value;
  } catch (Exception) {
    return null;
  }
}

List<T> readListSafe<T>(
    Map<dynamic, dynamic> json, String prop, T Function(dynamic) mapper) {
  if (json[prop] == null) return List.empty(growable: true);
  return (json[prop] as List).map((item) => mapper(item)).toList();
}
