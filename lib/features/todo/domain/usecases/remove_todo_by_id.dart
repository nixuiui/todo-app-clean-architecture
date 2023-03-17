import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';


class RemoveTodoById implements UseCase<bool, RemoveTodoParams> {
  final TodoRepository repository;

  RemoveTodoById(this.repository);

  @override
  Future<Either<Exception, bool>> call(RemoveTodoParams params) async {
    return repository.removeTodoByid(params);
  }
}

class RemoveTodoParams extends Equatable {
  final String id;

  const RemoveTodoParams({required this.id});

  @override
  List<Object> get props => [id];
}