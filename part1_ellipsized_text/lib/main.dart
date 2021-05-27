import 'package:flutter/material.dart';
import 'package:part1_ellipsized_text/ellipsized_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State {
  var _width = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                Slider(value: _width, onChanged: (value) => setState(() => _width = value)),
                Expanded(child: _buildText()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return CustomSingleChildLayout(
      delegate: _SingleChildLayoutDelegate(_width),
      child: Container(
        decoration: const BoxDecoration(border: Border(right: BorderSide())),
        child: EllipsizedText(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class _SingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  final double _width;

  _SingleChildLayoutDelegate(this._width);

  @override
  bool shouldRelayout(_SingleChildLayoutDelegate oldDelegate) {
    return oldDelegate._width != _width;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.copyWith(maxWidth: constraints.maxWidth * _width, minHeight: 0);
  }
}
