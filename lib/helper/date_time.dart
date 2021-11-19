extension FormatedDate on DateTime {
  String get ddmmaa {
    return "$day-$month-$year";
  }
}
