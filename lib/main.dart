import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_project/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // init hive => hive hoạt động giống local storage trên website
  Hive.init(appDocumentDirectory.path);

  // open a box
  await Hive.openBox("myBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.yellow, // Set the background color of AppBar
        // ),
        ),
    );
  }


}