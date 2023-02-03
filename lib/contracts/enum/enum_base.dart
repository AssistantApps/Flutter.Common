class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return map.map((k, v) => MapEntry(v, k));
  }
}
