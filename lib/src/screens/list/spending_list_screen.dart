import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/model/add_data.dart';
import '../../widgets/spending_item.dart';
import '../home/components/list_header.dart';

class SpendingListScreen extends StatefulWidget {
  const SpendingListScreen({super.key});

  @override
  State<SpendingListScreen> createState() => _SpendingListScreenState();
}

class _SpendingListScreenState extends State<SpendingListScreen> {
  final box = Hive.box<AddedData>('data');
  String sortOrder = 'byDate';

  @override
  void initState() {
    super.initState();

    box.listenable().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Spending List'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Income'),
              Tab(text: 'Expenses'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildMySpendingList('Income', true),
            buildMySpendingList('Others', false),
          ],
        ),
      ),
    );
  }

  Widget buildMySpendingList(String listType, bool isIncome) => Column(
        children: [
          SizedBox(height: 10),
          ListHeader(
            showSelectMenu: true,
            menuName: sortOrder,
            onSortOrderChanged: (value) {
              setState(() {
                sortOrder = value ?? 'byDate';
              });
              print(sortOrder);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 39.0),
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  List<AddedData> sortedList = List.from(box.values);

                  if (sortOrder == 'byDate') {
                    sortedList.sort((a, b) => a.datetime.compareTo(b.datetime));
                  } else if (sortOrder == 'byName') {
                    sortedList.sort((a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  } else if (sortOrder == 'byType') {
                    sortedList.sort((a, b) => a.IN.compareTo(b.IN));
                  }

                  List<AddedData> filteredList = isIncome
                      ? sortedList.where((data) => data.IN == 'Income').toList()
                      : sortedList
                          .where((data) => data.IN != 'Income')
                          .toList();

                  return filteredList.isEmpty
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
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            AddedData addedData = filteredList[index];
                            return getSpendingItem(addedData, index);
                          },
                        );
                },
              ),
            ),
          ),
        ],
      );

  Widget getSpendingItem(AddedData addedData, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        addedData.delete();
      },
      child: InkWell(
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('${addedData.explain}'),
          ),
        ),
        child: SpendingItem(
          balanceVisibility: true,
          spendingTypeVis: true,
          name: addedData.name,
          weekday: addedData.datetime.weekday,
          day: addedData.datetime.day,
          month: addedData.datetime.month,
          year: addedData.datetime.year,
          spendingType: addedData.IN,
          spendingAmount: addedData.amount,
        ),
      ),
    );
  }
}
