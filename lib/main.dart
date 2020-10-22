import 'package:flutter/material.dart';
import 'package:jobs/homepage.dart';
import 'package:jobs/jobmodel.dart';
import 'package:provider/provider.dart';
//import 'package:scoped_model/scoped_model.dart';



void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobController(),),
      ],
      child: MyApp()
  ),
  );
}


// how is Provider works

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}




// How is Scoped Model Works


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel(
//       model: JobController(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomePage(),
//       ),
//     );
//   }
// }