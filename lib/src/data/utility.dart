import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'model/add_data.dart';

int totals = 0;

final box = Hive.box<AddedData>('data');

int total() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

String formatMoney(int amount) {
  final formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$', 

  );

  return formatter.format(amount);
}

int income() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history2 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<AddedData> today() {
  List<AddedData> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<AddedData> week() {
  List<AddedData> a = [];
  DateTime date = new DateTime.now();
  var history2 = box.values.toList();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].datetime.day &&
        history2[i].datetime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<AddedData> month() {
  List<AddedData> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

List<AddedData> year() {
  List<AddedData> a = [];
  var history2 = box.values.toList();
  DateTime date = new DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<AddedData> history2) {
  List a = [0, 0];

  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List time(List<AddedData> history2, bool hour) {
  List<AddedData> a = [];
  List total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].datetime.hour == history2[c].datetime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].datetime.day == history2[c].datetime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  print(total);
  return total;
}
