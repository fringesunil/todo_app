import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/common/colors.dart';
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/core/common/enum.dart';
import 'package:todo_app/core/routes/route_string.dart';
import 'package:todo_app/screens/home/model/add_task_model.dart';
import 'package:todo_app/screens/home/model/task_details_model.dart';
import 'package:todo_app/screens/home/model/task_list_response_model.dart';
import 'package:todo_app/screens/home/model/user_list_response.model.dart';
import 'package:todo_app/screens/home/repository/home_repository.dart';

class HomeProvider extends HomeRepository with ChangeNotifier, CommonMethods {
  List<TaskListResponse>? taskList;
  List<UserListResponse>? userList;
  TextEditingController taskname = TextEditingController();
  TextEditingController taskdescription = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedUser;
  String? selectedUsername;
  String? selectedSatus;
  AddTaskResponse? newTask;
  TaskDetailsModel? taskDetails;
  String currentdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool isloading = false;

  void fetchtask(BuildContext context) async {
    taskList = await fetchtaskAPI(context);
    isloading = false;
    notifyListeners();
  }

  void fetchUser(BuildContext context) async {
    userList = await fetchuserAPI(context);
    isloading = false;
    notifyListeners();
  }

  void addTask(BuildContext context) async {
    final userdetails = await SharedPreferences.getInstance();
    Map data = {
      "taskname": taskname.text,
      "description": taskdescription.text,
      "duedate": dateController.text,
      "assignto": selectedUser,
      "status": selectedSatus,
      "createdby": userdetails.getString("userId"),
      "createdat": currentdate,
    };
    newTask = await addTaskAPI(context, data);
    goAndCloseAll(context, AppRoutes.home);
    flushAlert(context, ResponseType.success, "Task Added Successfully");
    clearAll();
    isloading = false;
    notifyListeners();
  }

  void updateTask(BuildContext context, String taskid) async {
    Map taskdetails = {
      "taskname": taskname.text,
      "description": taskdescription.text,
      "duedate": dateController.text,
      "assignto": selectedUser ?? taskDetails!.assignto!.id,
      "status": selectedSatus,
    };
    await updateTaskAPI(context, taskid, taskdetails);
    clearAll();
    goAndCloseAll(context, AppRoutes.home);
    flushAlert(context, ResponseType.success, "Task Updated Successfully");

    isloading = false;
    notifyListeners();
  }

  Future<void> fetchtaskdetails(BuildContext context, String taskId) async {
    taskDetails = await fetchTaskdetailsAPI(context, taskId);
    if (taskDetails != null) {
      addTaskValues(taskDetails!);
    }
    isloading = false;
    notifyListeners();
  }

  addTaskValues(TaskDetailsModel taskDetails) {
    taskname.text = taskDetails.taskname!;
    taskdescription.text = taskDetails.description!;
    dateController.text = taskDetails.duedate!;
    selectedUsername = taskDetails.assignto!.name;
    selectedSatus = taskDetails.status;
  }

  String useridByName(name) {
    int index = userList!.indexWhere((element) => element.name == name);
    if (index >= 0) {
      return userList![index].id.toString();
    } else {
      return "";
    }
  }

  clearAll() {
    taskname.clear();
    taskdescription.clear();
    dateController.clear();
    selectedSatus;
    selectedUser;
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Logout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                goAndCloseAll(context, AppRoutes.login); // Proceed with logout
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
