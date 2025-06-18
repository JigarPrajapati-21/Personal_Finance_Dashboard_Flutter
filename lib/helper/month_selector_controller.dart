import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthSelectorController extends GetxController {
  Rx<DateTime> currentMonth = DateTime.now().obs;

  void nextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
    );
  }

  void previousMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
    );
  }

  String get formattedMonthYear =>
      DateFormat('MMMM yyyy').format(currentMonth.value); // e.g., July 2026

  int get selectedMonth => currentMonth.value.month;
  int get selectedYear => currentMonth.value.year;
}
