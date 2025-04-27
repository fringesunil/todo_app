// To parse this JSON data, do
//
//     final taskListResponse = taskListResponseFromJson(jsonString);

import 'dart:convert';

List<TaskListResponse> taskListResponseFromJson(String str) => List<TaskListResponse>.from(json.decode(str).map((x) => TaskListResponse.fromJson(x)));

String taskListResponseToJson(List<TaskListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskListResponse {
    String? id;
    String? taskname;
    String? description;
    String? duedate;
    Assignto? assignto;
    String? status;
    Assignto? createdby;
    String? createdat;
    int? v;

    TaskListResponse({
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

    factory TaskListResponse.fromJson(Map<String, dynamic> json) => TaskListResponse(
        id: json["_id"],
        taskname: json["taskname"],
        description: json["description"],
        duedate: json["duedate"],
        assignto: json["assignto"] == null ? null : Assignto.fromJson(json["assignto"]),
        status: json["status"],
        createdby: json["createdby"] == null ? null : Assignto.fromJson(json["createdby"]),
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
