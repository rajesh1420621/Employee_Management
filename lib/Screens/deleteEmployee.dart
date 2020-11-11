import 'dart:convert';

import 'package:Employee_Management/Model/EmployeeModel.dart';
import 'package:Employee_Management/Screens/getEmployees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteEmployeeState();
  }
}

Future<EmployeeModel> deleteEmployees(String firstName, String lastName) async {
  var Url = "http://localhost:8080/deleteemployee";
  var response = await http.delete(
    Url,
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
  return EmployeeModel.fromJson(jsonDecode(response.body));
}

class deleteEmployeeState extends State<deleteEmployee> {
  @override
  Widget build(BuildContext context) {
    return getemployees();
  }
}
