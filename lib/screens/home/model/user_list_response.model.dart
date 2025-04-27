// To parse this JSON data, do
//
//     final userListResponse = userListResponseFromJson(jsonString);

import 'dart:convert';

List<UserListResponse> userListResponseFromJson(String str) => List<UserListResponse>.from(json.decode(str).map((x) => UserListResponse.fromJson(x)));

String userListResponseToJson(List<UserListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListResponse {
    String? id;
    String? name;
    String? userName;
    String? password;
    int? v;

    UserListResponse({
        this.id,
        this.name,
        this.userName,
        this.password,
        this.v,
    });

    factory UserListResponse.fromJson(Map<String, dynamic> json) => UserListResponse(
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
