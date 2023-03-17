import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/models/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/get_todo_list.dart';
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart';
import 'package:todoapp/features/todo/presentation/controllers/todo_controller.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'todo_controller_test.mocks.dart';

@GenerateMocks([AddTodo, GetTodoList, CheckTodo, RemoveTodoById])
void main() {

  late MockAddTodo addTodo;
  late MockGetTodoList getTodoList;
  late MockCheckTodo checkTodo;
  late MockRemoveTodoById removeTodoById;
  late TodoController controller;

  setUp(() {
    addTodo = MockAddTodo();
    getTodoList = MockGetTodoList();
    checkTodo = MockCheckTodo();
    removeTodoById = MockRemoveTodoById();
    controller = TodoController(
      getTodoList: getTodoList, 
      addTodo: addTodo, 
      checkTodo: checkTodo, 
      removeTodoById: removeTodoById
    );
  });

  final List<Todo> tTodoList = todoModelFromJson(fixture('todo_list.json'));

  group('TodoController.fetchTodoList():', () {
    test('should return the todoList has data when success retrive data from GetTodoList', () async {
      when(getTodoList.call(any)).thenAnswer((_) async => Right(tTodoList));
      await controller.fetchTodoList();
      expect(controller.todoList, tTodoList);
      expect(controller.todoList.length, 1);
    });
  });

  group('TodoController.inputTodoList():', () {
    test('should save the input data into Storage when input is not empty', () async {
      when(addTodo.call(any)).thenAnswer((_) async => const Right(true));
      when(getTodoList.call(any)).thenAnswer((_) async => Right(tTodoList));
      await controller.inputTodoList('Playing Football');

      const params = AddTodoParams(todo: 'Playing Football');
      verify(addTodo.call(params));
      verify(getTodoList.call(NoParams()));
    });

    test('should not does anything when input is empty', () async {
      await controller.inputTodoList('');
      verifyZeroInteractions(addTodo);
      verifyZeroInteractions(getTodoList);
    });
  });

  group('TodoController.checkTodoItem():', () {
    test('should checked status has updated when success do CheckTodo', () async {
      var todoListAfterCheck = tTodoList.map((e) {
        return Todo(id: e.id, todo: e.todo, checked: true);
      }).toList();

      when(checkTodo.call(any)).thenAnswer((_) async => const Right(true));
      when(getTodoList.call(any)).thenAnswer((_) async => Right(todoListAfterCheck));
      
      controller.todoList.value = tTodoList;
      await controller.checkTodoItem(0);

      const params = CheckTodoParams(id: 'id10', checked: true);
      verify(await checkTodo.call(params));
      verify(await getTodoList.call(NoParams()));
      expect(controller.todoList[0].checked, true);
    });

    test('should checked status has not updated when failed to do CheckTodo', () async {
      when(checkTodo.call(any)).thenAnswer((_) async => Left(Exception()));
      
      controller.todoList.value = tTodoList;
      await controller.checkTodoItem(0);

      verifyZeroInteractions(getTodoList);
      expect(controller.todoList[0].checked, false);
    });
  });

  group('TodoController.deleteTodoById():', () {
    test('should data reduce one item when success to do RemoveTodoById', () async {
      when(removeTodoById.call(any)).thenAnswer((_) async => const Right(true));
      when(getTodoList.call(any)).thenAnswer((_) async => const Right([]));
      
      controller.todoList.value = tTodoList;
      await controller.deleteTodoById('id10');

      const params = RemoveTodoParams(id: 'id10');
      verify(await removeTodoById.call(params));
      verify(await getTodoList.call(NoParams()));
      expect(controller.todoList.length, lessThan(tTodoList.length));
    });

    test('should data still same when failed to do RemoveTodoById', () async {
      when(removeTodoById.call(any)).thenAnswer((_) async => Left(Exception()));
      
      controller.todoList.value = tTodoList;
      await controller.deleteTodoById('id10');

      verifyZeroInteractions(getTodoList);
      expect(controller.todoList.length, equals(tTodoList.length));
    });
  });
  
}