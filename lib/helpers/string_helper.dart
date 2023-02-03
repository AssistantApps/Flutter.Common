String joinStringList(List<String> array, String separator) {
  if (array.isEmpty) return '';
  if (array.length == 1) return array[0];

  String result = '';
  int maxIndex = array.length - 1;
  for (int index = 0; index < maxIndex; index++) {
    result += array[index] + separator;
  }
  return result + array[maxIndex];
}

String padString(String input, int numChars) {
  String padding = '';
  for (int paddingIndex = 0;
      paddingIndex < numChars - input.length;
      paddingIndex++) {
    padding += '0';
  }
  return padding + input;
}
