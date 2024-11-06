
extension DateExtentions on DateTime {
  DateTime dateOnly (DateTime dateTime){
    return DateTime(
      dateTime.year ,
      dateTime.month ,
      dateTime.day,
    );
  }
}