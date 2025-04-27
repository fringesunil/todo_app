import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/common/colors.dart';
import 'package:todo_app/core/common/common_methods.dart';
import 'package:todo_app/core/routes/route_string.dart';
import 'package:todo_app/screens/home/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CommonMethods {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var homepro = Provider.of<HomeProvider>(context, listen: false);
    homepro.isloading = true;
    homepro.fetchtask(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, home, child) {
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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Task Manager",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                moveTo(context, AppRoutes.addtask);
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: CircleBorder(),
                              ),
                              tooltip: "Add Task",
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                home.showLogoutConfirmation(context);
                              },
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 28,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: CircleBorder(),
                              ),
                              tooltip: "Logout",
                            ),
                          ],
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
                      : home.taskList!.isEmpty
                          ? Center(
                              child: Text(
                                "No Data Found...",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: home.taskList!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await home.fetchtaskdetails(
                                            context, home.taskList![index].id!);
                                        moveTo(context, AppRoutes.updatetask);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 16),
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${home.taskList![index].taskname}",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: home.taskList![index]
                                                                .status ==
                                                            "Active"
                                                        ? AppColors.lightgreen
                                                        : home.taskList![index]
                                                                    .status ==
                                                                "Pending"
                                                            ? AppColors.lightred
                                                            : AppColors
                                                                .lightblue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    "${home.taskList![index].status}",
                                                    style: TextStyle(
                                                      color: home
                                                                  .taskList![
                                                                      index]
                                                                  .status ==
                                                              "Active"
                                                          ? AppColors.green
                                                          : home.taskList![index]
                                                                      .status ==
                                                                  "Pending"
                                                              ? AppColors.error
                                                              : Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                  color: Colors.grey.shade600,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "${home.taskList![index].createdat}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "${home.taskList![index].description}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
