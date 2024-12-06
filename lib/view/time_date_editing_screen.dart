// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_intshp/controller/task_controller.dart';
import 'package:to_do_intshp/model/task_model.dart';
import 'package:to_do_intshp/view/add_task_screen.dart';

class TimeDateEditingScreen extends StatefulWidget {
  const TimeDateEditingScreen({super.key, required this.index});
  final int index;

  @override
  State<TimeDateEditingScreen> createState() => _TimeDateEditingScreenState();
}

class _TimeDateEditingScreenState extends State<TimeDateEditingScreen> {
  String? selectedTask;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskController = context.watch<TaskController>();
    final task = taskController.getData[widget.index];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            task.task.toString(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            children: [
              Radio<String>(
                value: task.task.toString(),
                groupValue: task.task,
                onChanged: (value) {
                  setState(() {
                    selectedTask = value;
                  });
                },
                activeColor: Colors.white,
              ),
              Text(
                task.desc.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  titleController.text = task.task!.toString();
                  descController.text = task.desc!.toString();
                  dateController.text = task.date!.toString();

                  taskController.updateHiveData(
                      widget.index,
                      TaskModel(
                          task: titleController.text,
                          desc: descController.text,
                          date: dateController.text,
                          time: timeController.text));

                  showModalBottomSheet(
                      backgroundColor: Color.fromARGB(0, 11, 11, 11),
                      context: context,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "update note",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      controller: titleController,
                                      decoration: InputDecoration(
                                        labelText: 'Title',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      maxLines: 3,
                                      controller: descController,
                                      decoration: InputDecoration(
                                        labelText: 'Description',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      readOnly: true,
                                      controller: dateController,
                                      decoration: InputDecoration(
                                          labelText: 'Date',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none),
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                var selectedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(2020),
                                                        lastDate:
                                                            DateTime(2025));
                                                print(selectedDate.toString());
                                                if (selectedDate != null) {
                                                  dateController.text =
                                                      DateFormat("dd MMM y")
                                                          .format(selectedDate);
                                                }
                                              },
                                              icon:
                                                  Icon(Icons.calendar_month))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.center,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "ok",
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
                icon: Icon(Icons.edit_outlined),
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month,
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                  SizedBox(width: 10),
                  Text(
                    "Date:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      var selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      );
                      if (selectedDate != null) {
                        dateController.text =
                            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        dateController.text.isEmpty
                            ? "Select Date"
                            : dateController.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Time:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        timeController.text = selectedTime.format(context);
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        timeController.text.isEmpty
                            ? "Select Time"
                            : timeController.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      taskController.deleteHiveData(widget.index);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Delete Task",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}































//       ),
//     );
//   }
// }

