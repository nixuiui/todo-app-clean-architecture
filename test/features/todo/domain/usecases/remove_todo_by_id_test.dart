import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])

void main() {
  
  late RemoveTodoById usecase;
  late MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = RemoveTodoById(repository);
  });
  
  const params = RemoveTodoParams(id: 'id10');

  test('should return Todo List from repository when success remove todo item', () async {
    when(repository.removeTodoByid(any)).thenAnswer((_) async => const Right(true));

    final result = await usecase.call(params);

    verify(repository.removeTodoByid(params));
    expect(result, const Right(true));
  });

  test('should return CacheExeption from repository when failed to remove todo item', () async {
    when(repository.removeTodoByid(any)).thenAnswer((_) async => Left(CacheException()));

    final result = await usecase.call(params);
    verify(repository.removeTodoByid(params));
    
    expect(result, Left(CacheException()));
  });

}