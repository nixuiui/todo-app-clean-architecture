import 'package:todoapp/features/todo/todo_pages.dart';
import 'package:todoapp/features/todo/todo_routes.dart';

class AppPages {
  AppPages._();

  static final initial = todoRoutes.splash;

  static final routes = [
    ...todoPages,
  ];
}
