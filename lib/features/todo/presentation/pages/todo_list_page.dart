import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/features/todo/presentation/controllers/todo_controller.dart';
import 'package:todoapp/features/todo/presentation/widgets/input_todo_form.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_item_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  final todoController = TodoController.to;
  final inputController = TextEditingController();

  @override
  void initState() {
    todoController.fetchTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.separated(
              itemCount: todoController.todoList.length,
              separatorBuilder: (_, __) => const SizedBox.shrink(),
              padding: const EdgeInsets.symmetric(vertical: 16), 
              itemBuilder: (_, index) => TodoItemWidget(
                todo: todoController.todoList[index].todo, 
                checked: todoController.todoList[index].checked, 
                onPressed: () => todoController.checkTodoItem(index), 
                onDeleted: () => todoController.deleteTodoById(todoController.todoList[index].id)
              ), 
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.dialog(const InputTodoForm());
        },
      ),
    );
  }
}