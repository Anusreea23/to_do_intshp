// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:to_do_intshp/view/add_task_screen.dart';
import 'package:to_do_intshp/view/home_screen.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 30,
            )),
        title: Center(
          child: Text(
            "Index",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=600"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Image(
                image: NetworkImage(
                    "https://www.shutterstock.com/image-vector/business-man-giant-pencil-marked-260nw-1172328262.jpg")),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "What do yo you want to do today?",
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100,
                fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100,
                fontSize: 16),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade800,
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskWithDateTimeScreen(),
                        ));
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 50,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.timelapse,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
