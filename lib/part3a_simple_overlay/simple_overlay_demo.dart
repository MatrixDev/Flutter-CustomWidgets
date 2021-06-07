import 'dart:math';

import 'package:custom_widgets/demo_widget.dart';
import 'package:custom_widgets/part3a_simple_overlay/simple_overlay.dart';
import 'package:flutter/material.dart';

class SimpleOverlayDemoA extends DemoWidget {
  final title = 'Part 3a - FollowLeader';

  const SimpleOverlayDemoA();

  @override
  DemoWidgetState createState() => _SimpleOverlayDemoAState();
}

class _SimpleOverlayDemoAState extends DemoWidgetState {
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
    return SimpleOverlay(
      child: _buildImage(),
      overlay: _buildOverlay(),
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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Published on 07.06.2021',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
