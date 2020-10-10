import 'package:flutter/material.dart';
import 'package:jobs/homepage.dart';
import 'package:jobs/jobmodel.dart';
import 'package:scoped_model/scoped_model.dart';



void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: JobController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}