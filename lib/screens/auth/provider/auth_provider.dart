import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/core/common/enum.dart';
import 'package:todo_app/core/common/validators.dart';
import 'package:todo_app/core/routes/route_string.dart';
import 'package:todo_app/screens/auth/model/auth_model.dart';
import 'package:todo_app/screens/auth/model/signup_model.dart';
import 'package:todo_app/screens/auth/repository/auth_repository.dart';

class AuthProvider extends AuthRepository with ChangeNotifier, CommonMethods {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Validators validator = Validators();

  void login(BuildContext context) async {
    final userdetails = await SharedPreferences.getInstance();
    LoginResponse login = await loginAPI(context: context, logindetails: {
      "email": emailController.text,
      "password": passwordController.text
    });
    if (login.status!) {
      await userdetails.setString("userId", login.data!.id!);
      goAndCloseAll(context, AppRoutes.home);
      flushAlert(context, ResponseType.success, "Login Success");
      clearall();
      notifyListeners();
    }
  }

  void signup(BuildContext context) async {
    SignupResponse signup = await signupAPI(context: context, signupdetails: {
      "name": nameController.text,
      "userName": emailController.text,
      "password": passwordController.text
    });
    goAndCloseAll(context, AppRoutes.login);
    flushAlert(context, ResponseType.success, "Signup Success");
    clearall();
    notifyListeners();
  }

  clearall() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
