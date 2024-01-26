import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/data/model/add_data.dart';
import 'src/screens/splash/splash_screen.dart';


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
