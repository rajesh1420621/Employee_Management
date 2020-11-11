import 'dart:convert';

EmployeeModel employeeModelJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  int id;
  String firstName;
  String lastName;

  EmployeeModel({this.id, this.firstName, this.lastName});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      firstName: json["firstName"], lastName: json["lastName"], id: json["id"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        'id': id,
      };

  String get firstname => firstName;

  String get lastname => lastName;
}
