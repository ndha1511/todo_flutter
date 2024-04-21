import "package:flutter/material.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:mini_project/data/database.dart";
import "package:mini_project/utils/dialog_box.dart";
import "package:mini_project/utils/todo_tile.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box("myBox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
   
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }

  final _controller = TextEditingController(

  );


  void checkboxChange(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: const Center(child: Text("Todo")),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999.0),
          ),
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 40),
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTitle(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkboxChange(value, index),
                deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
