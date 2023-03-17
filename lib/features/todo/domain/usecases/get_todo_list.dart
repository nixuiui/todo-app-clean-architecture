import 'package:dartz/dartz.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';


class GetTodoList implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodoList(this.repository);

  @override
  Future<Either<Exception, List<Todo>>> call(NoParams params) {
    return Future.value(repository.getTodoList());
  }
}