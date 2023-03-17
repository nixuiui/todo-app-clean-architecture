import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/features/todo/data/repositories/todo_repositoy_impl.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/get_todo_list.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';
import 'package:todoapp/features/todo/presentation/controllers/todo_controller.dart';

class Injector {
  static void init() async {
    await serviceInjection();
    todoInjection();
  }
}

Future<void> serviceInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences, permanent: true);
}

Future<void> todoInjection() async {
  
  Get.lazyPut<TodoRepository>(() => TodoRepositoryImpl(
    localDataSource: TodoLocalDataSourceImpl(storage: Get.find()),
  ), fenix: true);

  Get.put(AddTodo(Get.find()), permanent: true);
  Get.put(CheckTodo(Get.find()), permanent: true);
  Get.put(GetTodoList(Get.find()), permanent: true);
  Get.put(RemoveTodoById(Get.find()), permanent: true);

  Get.put(TodoController(
    getTodoList: Get.find(),
    addTodo: Get.find(),
    checkTodo: Get.find(),
    removeTodoById: Get.find(),
  ), permanent: true);
}