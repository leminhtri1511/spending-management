import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/add_data.dart';
import '../../data/utility.dart';
import '../../widgets/spending_item.dart';
import 'components/background.dart';
import 'components/foreground.dart';
import 'components/list_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var addedData;
  String greeting = '';
  String currentHour = '';
  final box = Hive.box<AddedData>('data');

  late Timer timer;

  bool balanceVisibility = true;

  void updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;

    if (hour >= 0 && hour < 12 || (hour == 12 && minute == 0)) {
      greeting = 'Good morning';
    } else if (hour >= 12 && hour < 18 || (hour == 18 && minute == 0)) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
  }

  Future<void> loadBalanceVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      balanceVisibility = prefs.getBool('balanceVisibility') ?? true;
    });
  }

  Future<void> saveBalanceVisibility(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('balanceVisibility', value);
  }

  @override
  void initState() {
    super.initState();
    loadBalanceVisibility();
  updateGreeting();
    box.listenable().addListener(() {
    
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            buildSpendingList(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          Background(
            greetingText: greeting,
            userName: 'Minh Tri',
          ),
          Foreground(
            paddingTop: 70,
            balanceVisibility: balanceVisibility,
            totalBalance: total(),
            totalIncome: income(),
            totalExpenses: expenses(),
            onTap: () async {
              setState(() {
                balanceVisibility = !balanceVisibility;
              });
              await saveBalanceVisibility(balanceVisibility);
            },
          ),
        ],
      ),
    );
  }

  Widget buildSpendingList() {
    return Expanded(
      child: Column(
        children: [
          ListHeader(
            content: 'Spending history',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 39.0),
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  List<AddedData> sortedList = List.from(box.values);
                  sortedList.sort((a, b) => a.datetime.compareTo(b.datetime));

                  return sortedList.isEmpty
                      ? Center(
                          child: Text(
                            'Your list is empty right now!',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: sortedList.length,
                          itemBuilder: (context, index) {
                            AddedData addedData = sortedList[index];
                            return getSpendingItem(addedData, index);
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSpendingItem(AddedData addedData, int index) {
    return GestureDetector(
      onTap: balanceVisibility == true
          ? () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('${addedData.explain}'),
                ),
              )
          : () {},
      child: SpendingItem(
        balanceVisibility: balanceVisibility,
        spendingTypeVis: balanceVisibility,
        name: addedData.name,
        weekday: addedData.datetime.weekday,
        day: addedData.datetime.day,
        month: addedData.datetime.month,
        year: addedData.datetime.year,
        spendingType: addedData.IN,
        spendingAmount: addedData.amount,
      ),
    );
  }
}
