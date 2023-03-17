import 'package:equatable/equatable.dart';

class Todo extends Equatable {
    const Todo({
        required this.id,
        required this.todo,
        required this.checked,
    });

    final String id;
    final String todo;
    final bool checked;

    @override
    List<Object?> get props => [id, todo, checked];
}
