import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// region SimpleOverlay

class SimpleOverlay extends RenderObjectWidget {
  final Widget child;
  final Widget overlay;

  const SimpleOverlay({
    required this.child,
    required this.overlay,
  });

  @override
  RenderObjectElement createElement() {
    return SimpleOverlayElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SimpleOverlayRenderObject();
  }
}

// endregion

// region SimpleOverlayElement

class SimpleOverlayElement extends RenderObjectElement {
  // ...
  Element? _child;
  Element? _overlay;

  SimpleOverlayElement(SimpleOverlay widget) : super(widget);

  @override
  SimpleOverlay get widget {
    return super.widget as SimpleOverlay;
  }

  @override
  SimpleOverlayRenderObject get renderObject {
    return super.renderObject as SimpleOverlayRenderObject;
  }

  @override
  void mount(Element? parent, newSlot) {
    super.mount(parent, newSlot);

    _child = inflateWidget(widget.child, true);
    _overlay = inflateWidget(widget.overlay, false);
  }

  @override
  void update(SimpleOverlay newWidget) {
    super.update(newWidget);

    _child = updateChild(_child, newWidget.child, true);
    _overlay = updateChild(_overlay, newWidget.overlay, false);
  }

  @override
  void unmount() {
    super.unmount();

    _child = null;
    _overlay = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) visitor(_child!);
    if (_overlay != null) visitor(_overlay!);
  }

  @override
  void forgetChild(Element child) {
    super.forgetChild(child);
    if (_child == child) _child = null;
    if (_overlay == child) _overlay = null;
  }

  @override
  void insertRenderObjectChild(RenderBox child, bool slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }

  @override
  void moveRenderObjectChild(RenderBox child, bool oldSlot, bool newSlot) {
    renderObject.moveRenderObjectChild(child, oldSlot, newSlot);
  }

  @override
  void removeRenderObjectChild(RenderBox child, bool slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }
}

// endregion

// region SimpleOverlayRenderObject

class SimpleOverlayRenderObject extends RenderBox {
  //...
  RenderBox? _child;
  RenderBox? _overlay;

  // region Children Management

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _child?.attach(owner);
    _overlay?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _child?.detach();
    _overlay?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (_child != null) visitor(_child!);
    if (_overlay != null) visitor(_overlay!);
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    _child?.redepthChildren();
    _overlay?.redepthChildren();
  }

  void insertRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _child = child;
    } else {
      _overlay = child;
    }
    adoptChild(child);
  }

  void moveRenderObjectChild(RenderBox child, bool oldSlot, bool newSlot) {
    if (oldSlot) {
      _child = null;
    } else {
      _overlay = null;
    }
    if (newSlot) {
      _child = child;
    } else {
      _overlay = child;
    }
  }

  void removeRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _child = null;
    } else {
      _overlay = null;
    }
    dropChild(child);
  }

  // endregion

  // region Layout

  @override
  void performLayout() {
    var followerConstraints = constraints;

    final child = _child;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      followerConstraints = BoxConstraints.tight(child.size);
    }

    final overlay = _overlay;
    if (overlay != null) {
      overlay.layout(followerConstraints, parentUsesSize: true);
    }

    size = _child?.size ?? _overlay?.size ?? constraints.smallest;
  }

  // endregion

  // region Paint

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_child != null) {
      context.paintChild(_child!, offset);
    }
    if (_overlay != null) {
      context.paintChild(_overlay!, offset);
    }
  }

  // endregion

  // region Touch

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (_overlay?.hitTest(result, position: position) == true) {
      return true;
    }
    if (_child?.hitTest(result, position: position) == true) {
      return true;
    }
    return false;
  }

// endregion
}

// endregion
