import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../configs/app_colors.dart';
import '../../data/model/add_data.dart';
import '../../data/utility.dart';
import '../../widgets/chart.dart';
import '../../widgets/spending_item.dart';
import '../home/components/list_header.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier kj = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  int indexColor = 0;

  List day = ['Day', 'Week', 'Month', 'Year'];

  List f = [today(), week(), month(), year()];

  List<AddedData> sortListByDate(List<AddedData> list) {
    list.sort((a, b) => a.datetime.compareTo(b.datetime));
    return list;
  }

  final box = Hive.box<AddedData>('data');
  @override
  void initState() {
    super.initState();

    box.listenable().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: kj,
          builder: (BuildContext context, dynamic value, Widget? child) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: AppBar(
                    title: Text('Spending Chart'),
                    centerTitle: true,
                    backgroundColor: AppColors.primaryPur,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        4,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                indexColor = index;
                                kj.value = index;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: indexColor == index
                                    ? Color.fromARGB(255, 47, 125, 121)
                                    : Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day[index],
                                style: TextStyle(
                                  color: indexColor == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Chart(index: indexColor),
                ),
                ListHeader(content: 'Spending history'),
                Expanded(
                  child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        List<AddedData> sortedList = List.from(box.values);
                        sortedList
                            .sort((a, b) => a.datetime.compareTo(b.datetime));
                        AddedData addedData = sortedList[index];
                        return SpendingItem(
                          name: addedData.name,
                          weekday: addedData.datetime.weekday,
                          day: addedData.datetime.day,
                          month: addedData.datetime.month,
                          year: addedData.datetime.year,
                          spendingType: addedData.IN,
                          spendingAmount: addedData.amount,
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
