import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/person_info.dart';
import 'package:rick_and_morty_app/person_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        canvasColor: Colors.grey.shade800,
      ),
      routes: {
        '/list': (context) => PersonList(),
        '/info': (context) => PersonInfo(),
      },
      initialRoute: '/list',
    );
  }
}
