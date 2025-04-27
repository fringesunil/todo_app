import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/routes/route_string.dart';
import 'package:todo_app/core/routes/routes.dart';
import 'package:todo_app/screens/auth/page/login_screen.dart';
import 'package:todo_app/screens/auth/page/signup_screen.dart';
import 'package:todo_app/screens/auth/provider/auth_provider.dart';
import 'package:todo_app/screens/home/page/add_task_screen.dart';
import 'package:todo_app/screens/home/page/home_screen.dart';
import 'package:todo_app/screens/home/provider/home_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
