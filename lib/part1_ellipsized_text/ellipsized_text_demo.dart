import 'package:custom_widgets/demo_widget.dart';
import 'package:custom_widgets/part1_ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';

class EllipsizedTextDemo extends DemoWidget {
  final title = 'Part 1 - EllipsizedText';

  const EllipsizedTextDemo();

  @override
  DemoWidgetState createState() => _EllipsizedTextDemoState();
}

class _EllipsizedTextDemoState extends DemoWidgetState {
  var _fraction = 1.0;

  @override
  Widget buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 100),
        Slider(value: _fraction, onChanged: (value) => setState(() => _fraction = value)),
        Expanded(child: _buildTextExamples()),
      ],
    );
  }

  Widget _buildTextExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Text'),
        CustomSingleChildLayout(
          delegate: _SingleChildLayoutDelegate(_fraction),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Text('EllipsizedText'),
        CustomSingleChildLayout(
          delegate: _SingleChildLayoutDelegate(_fraction),
          child: EllipsizedText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _SingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  final double _width;

  _SingleChildLayoutDelegate(this._width);

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.constrainDimensions(double.infinity, 30);
  }

  @override
  bool shouldRelayout(_SingleChildLayoutDelegate oldDelegate) {
    return oldDelegate._width != _width;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.copyWith(maxWidth: constraints.maxWidth * _width, minHeight: 0);
  }
}
