import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todoapp/features/todo/data/models/todo_model.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'todo_local_data_resource_test.mocks.dart';

@GenerateMocks([SharedPreferences])

void main() {
  
  late TodoLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockStorage;

  setUp(() {
    mockStorage = MockSharedPreferences();
    dataSource = TodoLocalDataSourceImpl(
      storage: mockStorage
    );
  });

  group('TodoLocalDataSourceImpl.getTodoList():', () {
    final tTodoList = todoModelFromJson(fixture('todo_list.json'));

    test(
      'should return TodoList from GetStorage when there is data in storage',
      () async {
        // arrange
        when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
        // act
        final result = dataSource.getTodoList();
        // assert
        expect(result, equals(tTodoList));
      },
    );

    test(
      'should return empty list when there is no data in storage',
      () async {
        when(mockStorage.getString(any)).thenReturn(null);
        final result = dataSource.getTodoList();
        expect(result, equals([]));
      },
    );
  });

  group('TodoLocalDataSourceImpl.addTodo():', () {

    test('should return true when success add todo to storage', () async {
      when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
      when(mockStorage.setString(any, any)).thenAnswer((_) async => true);
      final result = await dataSource.addTodo(const AddTodoParams(todo: 'Playing guitar'));
      verify(mockStorage.setString(TODO_LIST_KEY, argThat(contains('Playing guitar'))));
      expect(result, isTrue);
    });

    test('should rethrow CacheExcepetion when failed to add todo to storage', () async {
      when(mockStorage.setString(any, any)).thenThrow(Exception());
      final result = dataSource.addTodo(const AddTodoParams(todo: 'Playing guitar'));
      expect(() => result, throwsA(const TypeMatcher<CacheException>()));
    });

  });

  group('TodoLocalDataSourceImpl.checkTodo():', () {

    test('should return true when success update check field in todo', () async {
      when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
      when(mockStorage.setString(any, any)).thenAnswer((_) async => true);
      final result = await dataSource.checkTodo(const CheckTodoParams(
        id: 'id10',
        checked: true,
      ));
      verify(mockStorage.setString(TODO_LIST_KEY, argThat(contains('true'))));
      expect(result, isTrue);
    });

    test('should rethrow CacheExcepetion when failed to update check field in todo', () async {
      when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
      when(mockStorage.setString(any, argThat(contains('true')))).thenThrow(Exception());
      final result = dataSource.checkTodo(const CheckTodoParams(
        id: 'id10',
        checked: true,
      ));
      expect(() => result, throwsA(const TypeMatcher<CacheException>()));
    });

  });

  group('TodoLocalDataSourceImpl.removeTodoByid():', () {

    test('should return true when success remove an todo item', () async {
      when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
      when(mockStorage.setString(any, any)).thenAnswer((_) async => true);
      final result = await dataSource.removeTodoByid(const RemoveTodoParams(
        id: 'id10'
      ));
      verify(mockStorage.setString(TODO_LIST_KEY, argThat(contains('[]'))));
      expect(result, isTrue);
    });

    test('should rethrow CacheExcepetion when failed to remove an todo item', () async {
      when(mockStorage.getString(any)).thenReturn(fixture('todo_list.json'));
      when(mockStorage.setString(any, any)).thenThrow(Exception());
      final result = dataSource.removeTodoByid(const RemoveTodoParams(
        id: 'id10'
      ));
      expect(() => result, throwsA(const TypeMatcher<CacheException>()));
    });

  });

}