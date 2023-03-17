import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    Key? key,
    required this.todo,
    required this.checked,
    required this.onPressed,
    required this.onDeleted,
  }) : super(key: key);

  final String todo;
  final bool checked;
  final Function()? onPressed;
  final Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(50)
        ),
        child: Center(
          child: Text(
            todo[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white
            ),
          )
        ),
      ),
      title: GestureDetector(
        onTap: onPressed?.call,
        child: Text(
          todo,
          style: TextStyle(
            color: checked ? Colors.grey : Colors.black,
            decoration: checked ? TextDecoration.lineThrough : null
          ),
        )
      ),
      trailing: IconButton(
        onPressed: onDeleted?.call, 
        icon: const Icon(Icons.delete)
      ),
    );
  }
}