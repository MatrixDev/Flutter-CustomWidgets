import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class DemoWidget extends StatefulWidget {
  String get title;

  const DemoWidget();

  @override
  DemoWidgetState createState();
}

abstract class DemoWidgetState extends State<DemoWidget> {
  Widget buildContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: buildContent(),
      ),
    );
  }
}
