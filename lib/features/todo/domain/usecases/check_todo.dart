import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';


class CheckTodo implements UseCase<bool, CheckTodoParams> {
  final TodoRepository repository;

  CheckTodo(this.repository);

  @override
  Future<Either<Exception, bool>> call(CheckTodoParams params) async {
    return repository.checkTodo(params);
  }
}

class CheckTodoParams extends Equatable {
  final String id;
  final bool checked;

  const CheckTodoParams({required this.id, required this.checked});

  @override
  List<Object> get props => [id, checked];
}