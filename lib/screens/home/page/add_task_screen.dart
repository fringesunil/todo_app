import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/colors.dart';
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/screens/home/provider/home_provider.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final String action;
  const AddTaskScreen({super.key, required this.action});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> with CommonMethods {
  @override
  void initState() {
    super.initState();
    var homepro = Provider.of<HomeProvider>(context, listen: false);
    homepro.isloading = true;
    homepro.fetchUser(context);
  }

  @override
  void dispose() {
    var homepro = Provider.of<HomeProvider>(context, listen: false);
    homepro.dateController.dispose();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    var homepro = Provider.of<HomeProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepOrange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepOrange,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        homepro.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (context, home, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrange.shade300,
                    Colors.deepOrange.shade100
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.action == "Add"
                                ? "Add New Task"
                                : "Update Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              home.clearAll();
                              back(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              shape: CircleBorder(),
                            ),
                            tooltip: "Close",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: home.isloading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orange,
                            ),
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Container(
                              width: size.width * 0.9,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: home.taskname,
                                    decoration: InputDecoration(
                                      hintText: "Task Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.task_alt,
                                        color: Colors.deepOrange.shade300,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: home.taskdescription,
                                    decoration: InputDecoration(
                                      hintText: "Description",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.description_outlined,
                                        color: Colors.deepOrange.shade300,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    value: home.selectedUsername,
                                    decoration: InputDecoration(
                                      hintText: "Assign To",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Colors.deepOrange.shade300,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: home.userList!.map((user) {
                                      return DropdownMenuItem<String>(
                                        value: user.name,
                                        child: Text(user.name!),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        home.selectedUser =
                                            home.useridByName(value);
                                      });
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    controller: home.dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "Due Date",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.deepOrange.shade300,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    onTap: () {
                                      selectDate(context);
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    value: home.selectedSatus,
                                    decoration: InputDecoration(
                                      hintText: "Status",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.info_outline,
                                        color: Colors.deepOrange.shade300,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: ['Active', 'Pending', 'Closed']
                                        .map((String status) {
                                      return DropdownMenuItem<String>(
                                        value: status,
                                        child: Text(status),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      home.selectedSatus = value;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      widget.action == "Add"
                                          ? home.addTask(context)
                                          : home.updateTask(
                                              context, home.taskDetails!.id!);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 3,
                                    ),
                                    child: Text(
                                      widget.action == "Add"
                                          ? "SAVE TASK"
                                          : "UPDATE TASK",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
