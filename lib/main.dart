import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'injector.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Todo List App",
      initialBinding: BindingsBuilder(Injector.init),
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
    ),
  );
}