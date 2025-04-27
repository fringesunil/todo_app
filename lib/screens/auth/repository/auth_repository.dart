import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/core/common/common_string.dart';
import 'package:todo_app/core/common/enum.dart';
import 'package:todo_app/screens/auth/model/auth_model.dart';
import 'package:todo_app/screens/auth/model/signup_model.dart';

class AuthRepository with CommonString, CommonMethods {
  loginAPI({required BuildContext context, required Map logindetails}) async {
    
    try {
      final response = await http.post(Uri.parse(baseUrl + 'auth/login'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(logindetails));
      if (response.statusCode == 200) {
        return loginResponseFromJson(response.body);
      } else if (response.statusCode == 401) {
        Navigator.of(context).pop();
        flushAlert(
            context, ResponseType.failure, "Invalid User name or Password");
      } else {
        Navigator.of(context).pop();
        flushAlert(context, ResponseType.failure,
            "Something went wrong===>${response.body}");
      }
    } catch (e) {
      Navigator.of(context).pop();
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  signupAPI({required BuildContext context, required Map signupdetails}) async {
    print("AA========>${signupdetails}");
    try {
      final response = await http.post(Uri.parse(baseUrl + 'user'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(signupdetails));
      if (response.statusCode == 200) {
        return signupResponseFromJson(response.body);
      } else {
        Navigator.of(context).pop();
        flushAlert(context, ResponseType.failure,
            "Something went wrong===>${response.body}");
      }
    } catch (e) {
      Navigator.of(context).pop();
      flushAlert(context, ResponseType.failure, "$e");
    }
  }
}
