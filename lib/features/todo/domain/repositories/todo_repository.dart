import 'package:dartz/dartz.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

abstract class TodoRepository {
  Either<Exception, List<Todo>> getTodoList();
  Future<Either<Exception, bool>> addTodo(AddTodoParams params);
  Future<Either<Exception, bool>> checkTodo(CheckTodoParams params);
  Future<Either<Exception, bool>> removeTodoByid(RemoveTodoParams params);
}
