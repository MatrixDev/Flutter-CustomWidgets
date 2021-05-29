import 'package:custom_widgets/demo_widget.dart';
import 'package:custom_widgets/part1_ellipsized_text/ellipsized_text_demo.dart';
import 'package:custom_widgets/part2_child_size/child_size_demo.dart';
import 'package:custom_widgets/part3_follow_leader/follow_leader_demo.dart';
import 'package:custom_widgets/part4_overflow_toolbar/overflow_toolbar_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Widget Examples',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Custom Widget Examples')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(context, const EllipsizedTextDemo()),
            _buildItem(context, const ChildSizeDemo()),
            _buildItem(context, const FollowLeaderDemo()),
            _buildItem(context, const OverflowToolbarDemo()),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, DemoWidget screen) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Text(screen.title, style: const TextStyle(fontSize: 20)),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }
}
