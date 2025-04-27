// To parse this JSON data, do
//
//     final addTaskResponse = addTaskResponseFromJson(jsonString);

import 'dart:convert';

AddTaskResponse addTaskResponseFromJson(String str) => AddTaskResponse.fromJson(json.decode(str));

String addTaskResponseToJson(AddTaskResponse data) => json.encode(data.toJson());

class AddTaskResponse {
    String? taskname;
    String? description;
    String? duedate;
    Assignto? assignto;
    String? status;
    String? createdby;
    String? createdat;
    String? id;
    int? v;

    AddTaskResponse({
        this.taskname,
        this.description,
        this.duedate,
        this.assignto,
        this.status,
        this.createdby,
        this.createdat,
        this.id,
        this.v,
    });

    factory AddTaskResponse.fromJson(Map<String, dynamic> json) => AddTaskResponse(
        taskname: json["taskname"],
        description: json["description"],
        duedate: json["duedate"],
        assignto: json["assignto"] == null ? null : Assignto.fromJson(json["assignto"]),
        status: json["status"],
        createdby: json["createdby"],
        createdat: json["createdat"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "taskname": taskname,
        "description": description,
        "duedate": duedate,
        "assignto": assignto?.toJson(),
        "status": status,
        "createdby": createdby,
        "createdat": createdat,
        "_id": id,
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
