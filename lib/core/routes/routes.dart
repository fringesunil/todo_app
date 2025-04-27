import 'package:flutter/material.dart';
import 'package:todo_app/core/routes/route_string.dart';
import 'package:todo_app/screens/auth/page/login_screen.dart';
import 'package:todo_app/screens/auth/page/signup_screen.dart';
import 'package:todo_app/screens/home/page/add_task_screen.dart';
import 'package:todo_app/screens/home/page/home_screen.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.login:
        return routeName(const LoginScreen());
      case AppRoutes.signup:
        return routeName(const SignupScreen());
      case AppRoutes.home:
        return routeName(HomeScreen());
      case AppRoutes.addtask:
        return routeName(AddTaskScreen(
          action: 'Add',
        ));
      case AppRoutes.updatetask:
        return routeName(AddTaskScreen(
          action: 'Update',
        ));
      default:
        return routeName(const LoginScreen());
    }
  }
}

MaterialPageRoute routeName(Widget route) {
  return MaterialPageRoute(builder: (_) => route);
}
