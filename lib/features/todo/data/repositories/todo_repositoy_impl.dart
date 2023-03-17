import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Either<Exception, List<Todo>> getTodoList() {
    final result = localDataSource.getTodoList();
    return Right(result);
  }

  @override
  Future<Either<Exception, bool>> addTodo(AddTodoParams params) async {
    try {
      final result = await localDataSource.addTodo(params);
      return Right(result);
    } on CacheException {
      return Left(CacheException());
    }
  }

  @override
  Future<Either<Exception, bool>> checkTodo(CheckTodoParams params) async {
    try {
      final result = await localDataSource.checkTodo(params);
      return Right(result);
    } on CacheException {
      return Left(CacheException());
    }
  }

  @override
  Future<Either<Exception, bool>> removeTodoByid(RemoveTodoParams params) async {
    try {
      final result = await localDataSource.removeTodoByid(params);
      return Right(result);
    } on CacheException {
      return Left(CacheException());
    }
  }

}