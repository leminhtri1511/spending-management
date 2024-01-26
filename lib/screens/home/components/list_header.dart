// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    this.content,
    this.onSortOrderChanged,
    this.showSelectMenu,
    this.menuName,
  }) : super(key: key);

  final String? content;
  final String? menuName;
  final void Function(String?)? onSortOrderChanged;
  final bool? showSelectMenu;

  String getSortOrderText(String sortOrder) {
    switch (sortOrder) {
      case 'byDate':
        return 'Sort by Date';
      case 'byName':
        return 'Sort by Name';
      case 'byType':
        return 'Sort by Type';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              color: Colors.black,
            ),
          ),
          // Text(
          //   content ?? '',
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 15,
          //     color: Colors.grey,
          //   ),
          // ),
          if (showSelectMenu == true)
            PopupMenuButton<String>(
              // icon: Icon(Icons.sort),
              child: Text('${getSortOrderText(menuName ?? '')}'),
              onSelected: onSortOrderChanged,
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'byDate',
                  child: Text('Sort by Date'),
                ),
                PopupMenuItem<String>(
                  value: 'byName',
                  child: Text('Sort by Name'),
                ),
                PopupMenuItem<String>(
                  value: 'byType',
                  child: Text('Sort by Type'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
