
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/get_todo_list.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

class TodoController extends GetxController {
  static TodoController get to => Get.find();

  TodoController({
    required this.getTodoList,
    required this.addTodo,
    required this.checkTodo,
    required this.removeTodoById,
  });

  late GetTodoList getTodoList;
  late AddTodo addTodo;
  late CheckTodo checkTodo;
  late RemoveTodoById removeTodoById;

  final todoList = RxList<Todo>([]);

  Future<void> fetchTodoList() async {
    final response = await getTodoList.call(NoParams());
    response.fold(
      (error) => null, 
      (result) {
        todoList.value = result;
      }
    );
  }

  Future<void> inputTodoList(String todo) async {
    if(todo != '') {
      final response = await addTodo.call(AddTodoParams(todo: todo));
      response.fold(
        (error) {
          debugPrint('Failed to delete');
        }, 
        (result) {
          fetchTodoList();
        }
      );
    }
  }

  Future<void> checkTodoItem(index) async {
    var todoItem = todoList[index];
    final response = await checkTodo.call(CheckTodoParams(id: todoItem.id, checked: !todoItem.checked));
    response.fold(
      (error) {
        debugPrint('Failed to check');
      }, 
      (result) async {
        await fetchTodoList();
      }
    );
  }

  Future<void> deleteTodoById(String id) async {
    final response = await removeTodoById.call(RemoveTodoParams(id: id));
    response.fold(
      (error) {
        debugPrint('Failed to delete');
      }, 
      (result) {
        fetchTodoList();
      }
    );
  }

}
