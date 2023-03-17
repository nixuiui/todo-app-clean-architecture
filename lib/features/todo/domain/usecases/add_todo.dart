import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';


class AddTodo implements UseCase<bool, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Exception, bool>> call(AddTodoParams params) async {
    return repository.addTodo(params);
  }
}

class AddTodoParams extends Equatable {
  final String todo;

  const AddTodoParams({required this.todo});

  @override
  List<Object> get props => [todo];
}