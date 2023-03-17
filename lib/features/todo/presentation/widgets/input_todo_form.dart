import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/features/todo/presentation/controllers/todo_controller.dart';

class InputTodoForm extends StatefulWidget {
  const InputTodoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<InputTodoForm> createState() => _InputTodoFormState();
}

class _InputTodoFormState extends State<InputTodoForm> {

  final todoController = TodoController.to;
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a new todo item',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              TextField(
                controller: inputController,
                onSubmitted: (value) {
                  todoController.inputTodoList(value);
                  inputController.text = '';
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      todoController.inputTodoList(inputController.text);
                      inputController.text = '';
                      Get.back();
                    }, 
                    child: const Text('Add')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}