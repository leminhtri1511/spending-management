import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:managment/src/screens/splash/splash_screen.dart';

import '../../Finance-App/lib/src/data/model/add_data.dart';
import '../../Finance-App/lib/src/widgets/bottom_bar.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddedDataAdapter());
  await Hive.openBox<AddedData>('data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      // home: BottomBar(),
      home: SplashScreen(),
    );
  }
}
