// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    User user;
    String accessToken;
    String refreshToken;
    String role;

    UserModel({
        required this.user,
        required this.accessToken,
        required this.refreshToken,
        required this.role,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "role": role,
    };
}

class User {
    String id;
    String userName;
    String password;
    String name;
    String role;

    User({
        required this.id,
        required this.userName,
        required this.password,
        required this.name,
        required this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        userName: json["username"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": userName,
        "password": password,
        "name": name,
        "role": role,
    };
}
