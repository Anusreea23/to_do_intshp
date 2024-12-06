// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:to_do_intshp/controller/task_controller.dart';
import 'package:to_do_intshp/model/task_model.dart';
import 'package:to_do_intshp/utils/app_sessions.dart';
import 'package:to_do_intshp/view/add_task_screen.dart';

import 'package:to_do_intshp/view/home_screen.dart';
import 'package:to_do_intshp/view/time_date_editing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  var box = await Hive.openBox<TaskModel>(AppSessions.notebox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
