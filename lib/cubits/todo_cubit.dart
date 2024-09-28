import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/models/todo_model.dart';

class ToDoCubit extends Cubit<List<TodoModel>> {
  final Box<TodoModel> _todoBox;

  ToDoCubit(this._todoBox) : super([]) {
    loadToDos();
  }

  void loadToDos() {
    if (_todoBox.isNotEmpty) {
      emit(_todoBox.values.toList());
    }
  }

  void addToDos(String title) {
    final newTask = TodoModel(isCompleted: false, taskName: title);
    _todoBox.add(newTask);
    emit([...state, newTask]);
  }

  void updateToDos(int index) {
    state[index].isCompleted = !state[index].isCompleted;
    _todoBox.putAt(index, state[index]);
    emit([...state]);
  }

  void deleteToDos(int index) {
    _todoBox.deleteAt(index);
    emit([...state]..removeAt(index));
  }
}
