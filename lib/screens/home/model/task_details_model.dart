// To parse this JSON data, do
//
//     final taskDetailsModel = taskDetailsModelFromJson(jsonString);

import 'dart:convert';

TaskDetailsModel taskDetailsModelFromJson(String str) =>
    TaskDetailsModel.fromJson(json.decode(str));

String taskDetailsModelToJson(TaskDetailsModel data) =>
    json.encode(data.toJson());

class TaskDetailsModel {
  String? id;
  String? taskname;
  String? description;
  String? duedate;
  Assignto? assignto;
  String? status;
  Assignto? createdby;
  String? createdat;
  int? v;

  TaskDetailsModel({
    this.id,
    this.taskname,
    this.description,
    this.duedate,
    this.assignto,
    this.status,
    this.createdby,
    this.createdat,
    this.v,
  });

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) =>
      TaskDetailsModel(
        id: json["_id"],
        taskname: json["taskname"],
        description: json["description"],
        duedate: json["duedate"],
        assignto: json["assignto"] == null
            ? null
            : Assignto.fromJson(json["assignto"]),
        status: json["status"],
        createdby: json["createdby"] == null
            ? null
            : Assignto.fromJson(json["createdby"]),
        createdat: json["createdat"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "taskname": taskname,
        "description": description,
        "duedate": duedate,
        "assignto": assignto?.toJson(),
        "status": status,
        "createdby": createdby?.toJson(),
        "createdat": createdat,
        "__v": v,
      };
}

class Assignto {
  String? id;
  String? name;
  String? userName;
  String? password;
  int? v;

  Assignto({
    this.id,
    this.name,
    this.userName,
    this.password,
    this.v,
  });

  factory Assignto.fromJson(Map<String, dynamic> json) => Assignto(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "password": password,
        "__v": v,
      };
}
