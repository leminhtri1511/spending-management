
import 'package:flutter/material.dart';

import '../../add/add.dart';

class ListAppBar extends StatelessWidget {
  const ListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(''),
          Text(
            'My Spending List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          FloatingActionButton(
            onPressed: () => openAddScreen(context),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void openAddScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => Add_Screen(),
    );
  }
}
