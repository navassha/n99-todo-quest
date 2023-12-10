import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:n99_todo_quest/model/todo_model.dart';

// there is  Created Riverpod provider for managing the todo list
final todoListProvider =
    StateNotifierProvider<TodoList, List<TodoModel>>((ref) {
  return TodoList();
});

//there is  Defining state notifier for managing the todo list
class TodoList extends StateNotifier<List<TodoModel>> {
  TodoList() : super([]);

  void addTodo(String title) {
    state = [...state, TodoModel(title: title)];
  }

  void removeTodo(int index) {
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }
}
