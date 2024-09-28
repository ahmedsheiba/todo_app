import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/cubits/todo_cubit.dart';
import 'package:note_app/data/models/todo_model.dart';
import 'package:note_app/data/todo_database.dart';
import 'package:note_app/widgets/dialog_box.dart';
import 'package:note_app/widgets/todo_tile.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  void onCancelDialog(BuildContext context) {
    _controller.clear();
    Navigator.pop(context);
  }

  void onSaveDialog(BuildContext context) {
    context.read<ToDoCubit>().addToDos(_controller.text);
    _controller.clear();
    Navigator.pop(context);
  }

  void createNewTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => onCancelDialog(context),
          onSave: () => onSaveDialog(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settingView');
              },
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.settings),
                  )))
        ],
      ),
      body: BlocBuilder<ToDoCubit, List<TodoModel>>(
        builder: (context, todoList) {
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todoList[index].taskName),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<ToDoCubit>().deleteToDos(index);
                  },
                  child: TodoTile(
                      isCompleted: todoList[index].isCompleted,
                      onChanged: (value) =>
                          context.read<ToDoCubit>().updateToDos(index),
                      taskName: todoList[index].taskName),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

final _controller = TextEditingController();
