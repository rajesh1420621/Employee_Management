import 'dart:convert';

import 'package:Employee_Management/Model/EmployeeModel.dart';
import 'package:Employee_Management/Screens/employeeDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateEmployee extends StatefulWidget {
  EmployeeModel employee;

  @override
  State<StatefulWidget> createState() {
    return updateEmployeeState(employee);
  }

  updateEmployee(this.employee);
}

Future<EmployeeModel> updateEmployees(
    EmployeeModel employee, BuildContext context) async {
  var Url = "http://localhost:8080/updateemployee";
  var response = await http.put(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(employee));
  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: 'Backend Response', content: response.body);
        });
  }
}

class updateEmployeeState extends State<updateEmployee> {
  EmployeeModel employee;
  final minimumPadding = 5.0;
  TextEditingController employeeNumber;
  bool _isEnabled = false;
  TextEditingController firstController;
  TextEditingController lastController;
  Future<List<EmployeeModel>> employees;

  updateEmployeeState(this.employee) {
    employeeNumber = TextEditingController(text: this.employee.id.toString());
    firstController = TextEditingController(text: this.employee.firstName);
    lastController = TextEditingController(text: this.employee.lastName);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Employee'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => employeeDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: employeeNumber,
                        enabled: _isEnabled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your ID';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Employee ID',
                            hintText: 'Enter Employee ID',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: firstController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter Your First Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: lastController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Enter Your First Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String firstName = firstController.text;
                        String lastName = lastController.text;
                        EmployeeModel emp = new EmployeeModel();
                        emp.id = employee.id;
                        emp.firstName = firstController.text;
                        emp.lastName = lastController.text;
                        EmployeeModel employees =
                            await updateEmployees(emp, context);
                        setState(() {
                          employee = employees;
                        });
                      })
                ]))));
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
