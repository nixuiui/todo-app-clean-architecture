import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])

void main() {
  
  late AddTodo usecase;
  late MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = AddTodo(repository);
  });
  
  const params = AddTodoParams(todo: 'Playing guitar');

  test('should return true from repository when success add todo item', () async {
    when(repository.addTodo(any)).thenAnswer((_) async => const Right(true));
    
    final result = await usecase.call(params);
    verify(repository.addTodo(params));

    expect(result, const Right(true));
  });

  test('should return CacheExeption from repository when failed to add todo item', () async {
    when(repository.addTodo(any)).thenAnswer((_) async => Left(CacheException()));

    final result = await usecase.call(params);
    verify(repository.addTodo(params));
    
    expect(result, Left(CacheException()));
  });

}