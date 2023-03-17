import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])

void main() {
  
  late CheckTodo usecase;
  late MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = CheckTodo(repository);
  });
  
  const params = CheckTodoParams(id: 'id10', checked: true);

  test('should return Todo List from repository when success update checkded field', () async {
    when(repository.checkTodo(any)).thenAnswer((_) async => const Right(true));

    final result = await usecase.call(params);

    verify(repository.checkTodo(params));
    expect(result, const Right(true));
  });

  test('should return CacheExeption from repository when failed to update checkded field', () async {
    when(repository.checkTodo(any)).thenAnswer((_) async => Left(CacheException()));

    final result = await usecase.call(params);
    verify(repository.checkTodo(params));
    
    expect(result, Left(CacheException()));
  });

}