import 'package:flutter/material.dart';
import 'package:note_app/widgets/dialog_box.dart';
import 'package:note_app/widgets/todo_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final _controller = TextEditingController();

class _HomeViewState extends State<HomeView> {
  List todoList = [
    ['DO', true],
    ['finish', false]
  ];

  void isCheckedBox(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void onCancelDialog() {
    _controller.clear();
    Navigator.pop(context);
  }

  void onSaveDialog() {
    setState(() {
      todoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: onCancelDialog,
          onSave: onSaveDialog,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todoList[index][0]),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });
              },
              child: TodoTile(
                  isCompleted: todoList[index][1],
                  onChanged: (value) => isCheckedBox(value, index),
                  taskName: todoList[index][0]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
