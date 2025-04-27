import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/core/common/common_string.dart';
import 'package:todo_app/core/common/enum.dart';
import 'package:todo_app/screens/home/model/add_task_model.dart';
import 'package:todo_app/screens/home/model/task_details_model.dart';
import 'package:todo_app/screens/home/model/task_list_response_model.dart';
import 'package:todo_app/screens/home/model/user_list_response.model.dart';

class HomeRepository with CommonString, CommonMethods {
  fetchtaskAPI(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'task'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return taskListResponseFromJson(response.body);
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  fetchuserAPI(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'user'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return userListResponseFromJson(response.body);
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  addTaskAPI(BuildContext context, Map taskdetails) async {
    try {
      final response = await http.post(Uri.parse(baseUrl + 'task'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(taskdetails));
      if (response.statusCode == 200) {
        return addTaskResponseFromJson(response.body);
      } else {
        flushAlert(context, ResponseType.failure, "Task Added Failed");
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  fetchTaskdetailsAPI(BuildContext context, String taskId) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'task/${taskId}'),
        headers: {
          'Content-type': 'application/json',
        },
      );
      print("STATUS CODE===============>${response.statusCode}");
      print("STATUS BODY===============>${response.body}");
      if (response.statusCode == 200) {
        return taskDetailsModelFromJson(response.body);
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, "$e");
    }
  }

  updateTaskAPI(BuildContext context, String taskId, Map taskdetails) async {
    print("Taskid===========>${taskId}");
    print("Task DEATIS===========>${taskdetails}");
    try {
      final response = await http.patch(Uri.parse(baseUrl + 'task/${taskId}'),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(taskdetails));
      print("AA===========>${response.statusCode}");
      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      flushAlert(context, ResponseType.failure, "$e");
    }
  }
}
