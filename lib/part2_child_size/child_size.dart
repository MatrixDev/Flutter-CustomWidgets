import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ChildSize extends SingleChildRenderObjectWidget {
  // ...
  final void Function(Size)? onChildSizeChanged;

  const ChildSize({
    Key? key,
    Widget? child,
    this.onChildSizeChanged,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderChildSize().._widget = this;
  }

  @override
  void updateRenderObject(BuildContext context, RenderChildSize renderObject) {
    renderObject.._widget = this;
  }
}

class RenderChildSize extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  // ...
  var _lastSize = Size.zero;
  var _widget = const ChildSize();

  @override
  void performLayout() {
    final child = this.child;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      size = constraints.smallest;
    }

    if (_lastSize != size) {
      _lastSize = size;
      _widget.onChildSizeChanged?.call(_lastSize);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result, position: position) == true;
  }
}
