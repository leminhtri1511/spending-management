// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../data/utility.dart';

class SpendingItem extends StatelessWidget {
  SpendingItem({
    Key? key,
    this.subtitle,
    this.trailing,
    this.name,
    this.weekday,
    this.day,
    this.month,
    this.year,
    this.spendingType,
    this.spendingAmount,
    this.balanceVisibility,
    this.spendingTypeVis,
  }) : super(key: key);

  final Widget? subtitle;
  final Widget? trailing;
  final String? name;
  final List<String> listOfDay = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final int? weekday;
  final int? day;
  final int? month;
  final int? year;
  final String? spendingType;
  final String? spendingAmount;
  final bool? balanceVisibility;
  final bool? spendingTypeVis;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${name}.png', height: 40),
      ),
      title: Text(
        name ?? '',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${listOfDay[weekday! - 1].substring(0, 3)}, ${day}-${month}-${year}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: spendingTypeVis == true ? SizedBox(
        width: 140,
        child: Text(
          balanceVisibility == true
              ? (spendingType == 'Income'
                  ? '+${formatMoney(int.parse(spendingAmount!))}'
                  : '-${formatMoney(int.parse(spendingAmount!))}')
              : '#####',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: balanceVisibility == true
                ? (spendingType == 'Income' ? Color(0xff368983) : Colors.red)
                : Colors.grey,
          ),
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        ),
      ) : Container(
        height: double.infinity,
        width: 7,
        decoration: BoxDecoration(
          color: spendingType == 'Income' ? Color(0xff368983) : Colors.red,
          borderRadius: BorderRadius.circular(99)
        ),
      ),
    );
  }
}
