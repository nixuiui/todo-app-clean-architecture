// Mocks generated by Mockito 5.3.2 from annotations
// in todoapp/test/features/todo/data/repositories/todo_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todoapp/features/todo/data/datasources/todo_local_data_source.dart'
    as _i2;
import 'package:todoapp/features/todo/data/models/todo_model.dart' as _i3;
import 'package:todoapp/features/todo/domain/usecases/add_todo.dart' as _i5;
import 'package:todoapp/features/todo/domain/usecases/check_todo.dart' as _i6;
import 'package:todoapp/features/todo/domain/usecases/remove_todo_by_id.dart'
    as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TodoLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoLocalDataSource extends _i1.Mock
    implements _i2.TodoLocalDataSource {
  MockTodoLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.TodoModel> getTodoList() => (super.noSuchMethod(
        Invocation.method(
          #getTodoList,
          [],
        ),
        returnValue: <_i3.TodoModel>[],
      ) as List<_i3.TodoModel>);
  @override
  _i4.Future<void> setTodoList(List<_i3.TodoModel>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #setTodoList,
          [data],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> addTodo(_i5.AddTodoParams? params) => (super.noSuchMethod(
        Invocation.method(
          #addTodo,
          [params],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> checkTodo(_i6.CheckTodoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #checkTodo,
          [params],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> removeTodoByid(_i7.RemoveTodoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTodoByid,
          [params],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
