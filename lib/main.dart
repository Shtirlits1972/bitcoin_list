import 'package:flutter/material.dart';
import 'CCList.dart';

void main() => runApp(CCTracer());

class CCTracer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCTracer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CCList(),
    );
  }
}
