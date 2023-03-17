import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/features/todo/data/models/todo_model.dart';
import 'package:todoapp/features/todo/data/repositories/todo_repositoy_impl.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'todo_repository_impl_test.mocks.dart';

@GenerateMocks([TodoLocalDataSource])

void main() {

  late TodoRepositoryImpl repository;
  late MockTodoLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockTodoLocalDataSource();
    repository = TodoRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('TodoRepositoryImpl.getTodoList():', () {
    final tTodoListModel = todoModelFromJson(fixture('todo_list.json'));
    final tTodoList = tTodoListModel;

    test('should return Todo List from local storage', () {
      when(mockLocalDataSource.getTodoList()).thenAnswer((_) => tTodoListModel);
      final result = repository.getTodoList();
      expect(result, Right(tTodoList));
    });
  });

  group('TodoRepositoryImpl.addTodo():', () {
    test('should return Right(true) when success add todo item', () async {
      when(mockLocalDataSource.addTodo(any)).thenAnswer((_) async => true);
      final result = await repository.addTodo(const AddTodoParams(todo: 'Playing guitar'));
      verify(mockLocalDataSource.addTodo(any));
      expect(result, const Right(true));
    });

    test('should return Left(CacheException) when failed to add todo item', () async {
      when(mockLocalDataSource.addTodo(any)).thenThrow(CacheException());
      final result = await repository.addTodo(const AddTodoParams(todo: 'Playing guitar'));
      verify(mockLocalDataSource.addTodo(any));
      expect(result, equals(Left(CacheException())));
    });
  });
  
  group('TodoRepositoryImpl.checkTodo():', () {
    test('should return Right(true) when success update check field', () async {
      when(mockLocalDataSource.checkTodo(any)).thenAnswer((_) async => true);
      final result = await repository.checkTodo(const CheckTodoParams(id: 'id10', checked: true));
      verify(mockLocalDataSource.checkTodo(any));
      expect(result, const Right(true));
    });

    test('should return Left(CacheException) when failed update check field', () async {
      when(mockLocalDataSource.checkTodo(any)).thenThrow(CacheException());
      final result = await repository.checkTodo(const CheckTodoParams(id: 'id10', checked: true));
      verify(mockLocalDataSource.checkTodo(any));
      expect(result, equals(Left(CacheException())));
    });
  });

  group('TodoRepositoryImpl.removeTodoByid():', () {
    test('should return Right(true) when success remove todo', () async {
      when(mockLocalDataSource.removeTodoByid(any)).thenAnswer((_) async => true);
      final result = await repository.removeTodoByid(const RemoveTodoParams(id: 'id10'));
      verify(mockLocalDataSource.removeTodoByid(any));
      expect(result, const Right(true));
    });

    test('should return Left(CacheException) when failed remove todo', () async {
      when(mockLocalDataSource.removeTodoByid(any)).thenThrow(CacheException());
      final result = await repository.removeTodoByid(const RemoveTodoParams(id: 'id10'));
      verify(mockLocalDataSource.removeTodoByid(any));
      expect(result, equals(Left(CacheException())));
    });
  });
  
}