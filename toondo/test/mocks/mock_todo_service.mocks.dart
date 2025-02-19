// Mocks generated by Mockito 5.4.5 from annotations
// in toondo/test/mocks/mock_todo_service.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:toondo/services/todo_service.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoService extends _i1.Mock implements _i3.TodoService {
  MockTodoService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i2.Client get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i2.Client);

  @override
  _i5.Future<List<dynamic>> loadTodoList() => (super.noSuchMethod(
        Invocation.method(
          #loadTodoList,
          [],
        ),
        returnValue: _i5.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i5.Future<List<dynamic>>);

  @override
  _i5.Future<void> saveTodoList(List<dynamic>? todos) => (super.noSuchMethod(
        Invocation.method(
          #saveTodoList,
          [todos],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> addTodo(dynamic todo) => (super.noSuchMethod(
        Invocation.method(
          #addTodo,
          [todo],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateTodo(dynamic updatedTodo) => (super.noSuchMethod(
        Invocation.method(
          #updateTodo,
          [updatedTodo],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateTodoStatus(
    String? todoId,
    double? status,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTodoStatus,
          [
            todoId,
            status,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> updateTodoDates(dynamic todo) => (super.noSuchMethod(
        Invocation.method(
          #updateTodoDates,
          [todo],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> deleteTodoById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTodoById,
          [id],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  dynamic getTodoById(String? id) => super.noSuchMethod(Invocation.method(
        #getTodoById,
        [id],
      ));

  @override
  _i5.Future<void> commitTodos() => (super.noSuchMethod(
        Invocation.method(
          #commitTodos,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> fetchTodos() => (super.noSuchMethod(
        Invocation.method(
          #fetchTodos,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<int> getUnsyncedTodosCount() => (super.noSuchMethod(
        Invocation.method(
          #getUnsyncedTodosCount,
          [],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
}
