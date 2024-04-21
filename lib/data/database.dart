import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  final _myBox = Hive.box("myBox");


  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    todoList = [
      ["Learn react", false],
      ["Learn flutter", false]
    ];
  }

  // load data form hive
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update data
  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }

}