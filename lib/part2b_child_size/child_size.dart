import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// region ChildSize

class ChildSize extends RenderObjectWidget {
  // ...
  final Widget? child;
  final void Function(Size)? onChildSizeChanged;

  const ChildSize({
    Key? key,
    this.child,
    this.onChildSizeChanged,
  }) : super(key: key);

  @override
  RenderObjectElement createElement() {
    return ChildSizeElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderChildSize().._widget = this;
  }

  @override
  void updateRenderObject(BuildContext context, RenderChildSize renderObject) {
    renderObject.._widget = this;
  }
}

// endregion

// region ChildSizeElement

class ChildSizeElement extends RenderObjectElement {
  // ...
  Element? _child;

  ChildSizeElement(ChildSize widget) : super(widget);

  @override
  ChildSize get widget {
    return super.widget as ChildSize;
  }

  @override
  RenderChildSize get renderObject {
    return super.renderObject as RenderChildSize;
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _child = updateChild(_child, widget.child, null);
  }

  @override
  void update(ChildSize newWidget) {
    super.update(newWidget);
    _child = updateChild(_child, newWidget.child, null);
  }

  @override
  void unmount() {
    super.unmount();
    _child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }

  @override
  void removeRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }
}

// endregion

// region RenderChildSize

class RenderChildSize extends RenderBox {
  // ...
  RenderBox? _child;
  var _lastSize = Size.zero;
  var _widget = const ChildSize();

  // region Children Management

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _child?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _child?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    final child = _child;
    if (child != null) {
      visitor(child);
    }
    super.visitChildren(visitor);
  }

  @override
  void redepthChildren() {
    final child = _child;
    if (child != null) {
      redepthChild(child);
    }
    super.redepthChildren();
  }

  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    assert(_child == null);
    _child = child;
    adoptChild(child);
  }

  void removeRenderObjectChild(RenderBox child, covariant Object? slot) {
    assert(_child == child);
    _child = null;
    dropChild(child);
  }

  // endregion

  // region Layout

  @override
  void performLayout() {
    final child = _child;
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

  // endregion

  // region Paint

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = _child;
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  // endregion

  // region HitTest

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return _child?.hitTest(result, position: position) == true;
  }

// endregion

}

// endregion
