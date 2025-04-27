// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  String? id;
  String? userName;
  String? name;

  SignupResponse({
    this.id,
    this.userName,
    this.name,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        id: json["_id"],
        userName: json["userName"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "name": name,
      };
}
