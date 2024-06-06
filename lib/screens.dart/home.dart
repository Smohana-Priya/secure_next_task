// lib/screens.dart/home.dart
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _employees = [];
  String? _ageGroup;

  @override
  void initState() {
    super.initState();
    _loadAgeGroup();
  }

  void _loadAgeGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ageGroup = prefs.getString('age_group');
    });
    _fetchEmployees();
  }

  void _fetchEmployees() async {
    try {
      var dio = Dio();
      final response =
          await dio.get('https://dummy.restapiexample.com/api/v1/employees');

      if (response.statusCode == 200) {
        List employees = response.data['data'];

        int maxAge;
        if (_ageGroup == 'below 30') {
          maxAge = 30;
        } else if (_ageGroup == 'below 40') {
          maxAge = 40;
        } else if (_ageGroup == 'below 50') {
          maxAge = 50;
        } else {
          maxAge = 60;
        }

        setState(() {
          _employees = employees
              .where((employee) => employee['employee_age'] < maxAge)
              .toList();
        });
      } else {
        throw Exception('Failed to load employees');
      }
    } on DioException catch (e) {
      print('inside the DioException-----------$e');
    }
  }

  void _changeAgeGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('age_group');
    Navigator.pushReplacementNamed(context, '/age_selection');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Employee List',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: _changeAgeGroup,
              )
            ],
          ),
          body: _employees.isNotEmpty
              ? ListView.builder(
                  itemCount: _employees.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_employees[index]['employee_name']),
                      subtitle:
                          Text('Age: ${_employees[index]['employee_age']}'),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
