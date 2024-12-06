// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_do_intshp/model/task_model.dart';
import 'package:to_do_intshp/utils/app_sessions.dart';
import 'package:to_do_intshp/view/home_screen.dart';

class AddTaskWithDateTimeScreen extends StatefulWidget {
  const AddTaskWithDateTimeScreen({super.key});

  @override
  State<AddTaskWithDateTimeScreen> createState() =>
      _AddTaskWithDateTimeScreenState();
}

class _AddTaskWithDateTimeScreenState extends State<AddTaskWithDateTimeScreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          if (taskController.text.isEmpty ||
              descriptionController.text.isEmpty ||
              dateController.text.isEmpty ||
              timeController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Please fill all fields!",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            try {
              var box = Hive.box<TaskModel>(AppSessions.notebox);
              await box.add(
                TaskModel(
                  task: taskController.text,
                  desc: descriptionController.text,
                  date: dateController.text,
                  time: timeController.text,
                ),
              );
              log('add success');
            } catch (e) {
              log(e.toString());
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          }
        },
        child: Icon(Icons.check, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: taskController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter a Task",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Description",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter Description",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Date",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: dateController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Select Date",
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_month, color: Colors.white),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025),
                    );
                    if (selectedDate != null) {
                      dateController.text =
                          DateFormat('dd MMM yyyy').format(selectedDate);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Time",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: timeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Select Time",
                labelStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.access_time, color: Colors.white),
                  onPressed: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      timeController.text = selectedTime.format(context);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
