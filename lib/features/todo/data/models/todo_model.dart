import 'dart:convert';

import 'package:todoapp/features/todo/domain/entities/todo.dart';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel extends Todo {
    const TodoModel({
        required String id,
        required String todo,
        required bool checked,
    }) : super(id: id, todo: todo, checked: checked);

    TodoModel copyWith({
      String? id,
      String? todo,
      bool? checked,
    }) {
      return TodoModel(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        checked: checked ?? this.checked,
      );
    }

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        todo: json["todo"],
        checked: json["checked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "checked": checked,
    };
}