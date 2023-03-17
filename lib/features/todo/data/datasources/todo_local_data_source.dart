import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/data/models/todo_model.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

abstract class TodoLocalDataSource {
  List<TodoModel> getTodoList();
  Future<void> setTodoList(List<TodoModel> data);
  Future<bool> addTodo(AddTodoParams params);
  Future<bool> checkTodo(CheckTodoParams params);
  Future<bool> removeTodoByid(RemoveTodoParams params);
}

const String TODO_LIST_KEY = 'TODO_LIST';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {

  final SharedPreferences storage;

  TodoLocalDataSourceImpl({
    required this.storage
  });

  @override
  Future<bool> setTodoList(List<TodoModel> data) async {
    try {
      var str = json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
      return await storage.setString(TODO_LIST_KEY, str);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<TodoModel> getTodoList() {
    final str = storage.getString(TODO_LIST_KEY);
    if(str != null) {
      return List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));
    }
    return [];
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<bool> addTodo(AddTodoParams params) async {
    try {
      var localData = getTodoList();
      localData.add(TodoModel(
        id: UniqueKey().toString(), 
        todo: params.todo, 
        checked: false
      ));
      await setTodoList(localData);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> checkTodo(CheckTodoParams params) async {
    try {
      var localData = getTodoList();
      var index = localData.indexWhere((e) => e.id == params.id);
      if(index > -1) {
        localData[index] = localData[index].copyWith(
          checked: params.checked
        );
      }
      await setTodoList(localData);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> removeTodoByid(RemoveTodoParams params) async {
    try {
      var localData = getTodoList();
      localData.removeWhere((e) => e.id == params.id);
      await setTodoList(localData);
      return true;
    } catch (e) {
      throw CacheException();
    }
  }

}