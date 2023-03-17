import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/models/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/repositories/todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/get_todo_list.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'add_todo_test.mocks.dart';

@GenerateMocks([TodoRepository])

void main() {
  
  late GetTodoList usecase;
  late MockTodoRepository repository;

  setUp(() {
    repository = MockTodoRepository();
    usecase = GetTodoList(repository);
  });
  
  final List<Todo> tTodoList = todoModelFromJson(fixture('todo_list.json'));

  test('should return Todo List from repository when success retrive todo list', () async {
    when(repository.getTodoList()).thenAnswer((_) => Right(tTodoList));

    final result = await usecase.call(NoParams());

    verify(repository.getTodoList());
    expect(result, Right(tTodoList));
  });

}