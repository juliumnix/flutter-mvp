import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/todo.dart';

class Presenter {
  List<ToDo>? getFoundToDo() {}
  void insertData() {}
  void handleToDoChange(ToDo todo) {}
  void deleteToDoItem(String id) {}
  void addToDoItem(String toDo, TextEditingController todoController) {}
  void runFilter(String enteredKeyword) {}
}

class BasicPresenter implements Presenter {
  List<ToDo> _foundToDo = [];
  final _todosList = ToDo.todoList();

  List<ToDo> getTodosList() {
    return _todosList;
  }

  List<ToDo> getFoundToDo() {
    return _foundToDo;
  }

  void insertData() {
    _foundToDo = _todosList;
  }

  void handleToDoChange(ToDo todo) {
    todo.isDone = !todo.isDone;
  }

  void deleteToDoItem(String id) {
    _todosList.removeWhere((item) => item.id == id);
  }

  void addToDoItem(String toDo, TextEditingController todoController) {
    _todosList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    ));
    todoController.clear();
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = _todosList;
    } else {
      results = _todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    _foundToDo = results;
  }
}
