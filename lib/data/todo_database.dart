import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/models/todo_model.dart';

class TodoDatabase {
  final _myBox = Hive.box<TodoModel>('todoBox');

  void addTaoDO(TodoModel todoModel) {
    _myBox.add(todoModel);
  }

  List<TodoModel> getTodo() {
    return _myBox.isEmpty ? _myBox.values.toList() : [];
  }

  void deleteToDo(int index) {
    _myBox.deleteAt(index);
  }

  void updateToDo(int index, TodoModel todoModel) {
    _myBox.putAt(index, todoModel);
  }
}
