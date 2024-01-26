// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:managment/src/configs/app_colors.dart';

import '../../../data/utility.dart';

class Foreground extends StatefulWidget {
  Foreground({
    Key? key,
    this.totalBalance,
    this.totalIncome,
    this.totalExpenses,
    this.paddingTop,
    this.balanceVisibility,
    this.onTap,
  }) : super(key: key);

  final int? totalBalance;
  final int? totalIncome;
  final int? totalExpenses;
  final double? paddingTop;
  final VoidCallback? onTap;
  final bool? balanceVisibility;
  @override
  State<Foreground> createState() => _ForegroundState();
}

class _ForegroundState extends State<Foreground> {
  // bool balanceVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: widget.paddingTop ?? 0),
        child: Container(
          height: 170,
          width: 320,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                // color: Color.fromRGBO(47, 125, 121, 0.3),
                color: const Color.fromARGB(65, 104, 58, 183),
                offset: Offset(0, 6),
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            color: AppColors.primaryPur,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  IconButton(
                    onPressed: widget.onTap,
                    icon: Icon(
                      widget.balanceVisibility == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.balanceVisibility == true
                          ? '${formatMoney(widget.totalBalance!)}'
                          : '#####',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white.withOpacity(0.9),
                        // color: widget.balanceVisibility == false
                        //     ? Colors.grey
                        //     : (total() < 0 ? Colors.red : Color(0xff368983)),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.balanceVisibility == false
                            ? () {}
                            : () => showSpending(context, 'Income', income()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 216, 216, 216),
                                  ),
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      const Color.fromARGB(255, 131, 117, 170),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.balanceVisibility == true
                                  ? '${formatMoney(widget.totalIncome!)}'
                                  : '#####',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.balanceVisibility == false
                            ? () {}
                            : () =>
                                showSpending(context, 'Expenses', expenses()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Expenses',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 216, 216, 216),
                                  ),
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      const Color.fromARGB(255, 131, 117, 170),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.balanceVisibility == true
                                  ? '${formatMoney(widget.totalExpenses!)}'
                                  : '#####',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSpending(BuildContext context, String type, int amount) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        content: Text(
          '${formatMoney(amount)}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
