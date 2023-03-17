import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/features/todo/todo_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Get.offNamed(todoRoutes.todoList)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('TODO APP')
      ),
    );
  }
}