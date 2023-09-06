import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.userDetails,
    });
    final UserDetails userDetails;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userDetails: UserDetails.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": userDetails.toJson(),
    };
}

class UserDetails {
    UserDetails({
      required  this.idUser,
      required  this.username,
      required  this.password,
    });

    final int idUser;
    final String username;
    final String password;

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        idUser: json["idUser"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "username": username,
        "password": password,
    };

  
}