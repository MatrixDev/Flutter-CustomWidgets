import 'dart:math';

import 'package:custom_widgets/demo_widget.dart';
import 'package:custom_widgets/part3_follow_leader/follow_leader.dart';
import 'package:flutter/material.dart';

class FollowLeaderDemo extends DemoWidget {
  final title = 'Part 3 - FollowLeader';

  const FollowLeaderDemo();

  @override
  DemoWidgetState createState() => _FollowLeaderDemoState();
}

class _FollowLeaderDemoState extends DemoWidgetState {
  var _size = 1.0;

  @override
  Widget buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 100),
        Slider(value: _size, onChanged: (value) => setState(() => _size = value)),
        Center(child: _buildContent()),
      ],
    );
  }

  Widget _buildContent() {
    return FollowLeader(
      leader: _buildImage(),
      follower: _buildOverlay(),
    );
  }

  Widget _buildImage() {
    return LayoutBuilder(builder: (_, constraints) {
      return ColoredBox(
        color: Colors.amber,
        child: Icon(
          Icons.image,
          color: Colors.yellow,
          size: min(constraints.maxWidth, constraints.maxHeight) * _size,
        ),
      );
    });
  }

  Widget _buildOverlay() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: Text(
        'Published on 27.06.2021',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
