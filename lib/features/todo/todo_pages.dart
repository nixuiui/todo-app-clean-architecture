import 'package:get/get.dart';
import 'package:todoapp/features/todo/presentation/pages/splash_page.dart';
import 'package:todoapp/features/todo/presentation/pages/todo_list_page.dart';
import 'package:todoapp/features/todo/todo_routes.dart';

final todoPages = [
  GetPage(
    name: todoRoutes.splash,
    page: () => const SplashPage(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
  GetPage(
    name: todoRoutes.todoList,
    page: () => const TodoListPage(),
    participatesInRootNavigator: true,
    preventDuplicates: true,
  ),
];