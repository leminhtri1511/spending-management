import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managment/src/screens/list/spending_list_screen.dart';

import '../screens/add/add.dart';
import '../screens/home/home_screen.dart';
import '../screens/static/statistics.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectIndex = 0;
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();

  Widget build(BuildContext context) {
    return Scaffold(
 
      bottomNavigationBar: CupertinoTabScaffold(

        tabBar: CupertinoTabBar(
          inactiveColor: Colors.grey,
          backgroundColor: const Color.fromARGB(179, 239, 236, 236),
          onTap: (index) {
            if (selectIndex == index) {
              switch (index) {
                case 0:
                  firstTabNavKey.currentState?.popUntil((r) => r.isFirst);
                  break;
                case 1:
                  secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
                  break;
                case 2:
                  thirdTabNavKey.currentState?.popUntil((r) => r.isFirst);
                  break;
                case 3:
                  fourthTabNavKey.currentState?.popUntil((r) => r.isFirst);
                  break;
              }
            }
            selectIndex = index;
            setState(() {});
            print(index);
            // notifyListeners();
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill),
              // label: NavigationLanguage.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              activeIcon: Icon(Icons.pie_chart_rounded),
              // label: NavigationLanguage.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill),
              // label: NavigationLanguage.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              activeIcon: Icon(Icons.pie_chart_rounded),
              // label: NavigationLanguage.home,
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                navigatorKey: firstTabNavKey,
                builder: (context) => const HomeScreen(),
              );
            case 1:
              return CupertinoTabView(
                navigatorKey: secondTabNavKey,
                builder: (context) => const Statistics(),
              );
            case 2:
              return CupertinoTabView(
                navigatorKey: thirdTabNavKey,
                builder: (context) => const SpendingListScreen(),
              );
            case 3:
              return CupertinoTabView(
                navigatorKey: fourthTabNavKey,
                builder: (context) => const Add_Screen(),
              );

            default:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(child: HomeScreen());
                },
              );
          }
        },
      ),
    );
  }
}
