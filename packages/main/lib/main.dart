import 'package:flutter/material.dart';
import 'package:main/drag_container.dart';

import 'drag_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        color: Colors.grey[200],
        child: DragState(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DragContainer(items: const [1, 2, 3]),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(),
              ),
              DragContainer(items: const [4, 5, 6]),
            ],
          ),
        ),
      ),
    );
  }
}
