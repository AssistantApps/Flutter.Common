String simpleDate(DateTime dateTime) =>
    "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

bool isValentinesPeriod() {
  var currentDate = DateTime.now();
  if (currentDate.month == 2 && currentDate.day >= 13 && currentDate.day < 15) {
    return true;
  }
  return false;
}
