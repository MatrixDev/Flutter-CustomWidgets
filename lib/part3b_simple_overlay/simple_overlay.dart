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
  Element? _leader;
  Element? _follower;

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

    _leader = inflateWidget(widget.child, true);
    _follower = inflateWidget(widget.overlay, false);
  }

  @override
  void update(SimpleOverlay newWidget) {
    super.update(newWidget);

    _leader = updateChild(_leader, newWidget.child, true);
    _follower = updateChild(_follower, newWidget.overlay, false);
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_leader != null) visitor(_leader!);
    if (_follower != null) visitor(_follower!);
  }

  @override
  void forgetChild(Element child) {
    super.forgetChild(child);
    if (_leader == child) _leader = null;
    if (_follower == child) _follower = null;
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

// region SimpleOverlayChild

class _SimpleOverlayChild extends BoxParentData {
  final RenderBox renderBox;
  final activePointers = <int>{};

  var hitTestResult = BoxHitTestResult();

  _SimpleOverlayChild(this.renderBox);
}

// endregion

// region SimpleOverlayRenderObject

class SimpleOverlayRenderObject extends RenderBox {
  RenderBox? _leader;
  RenderBox? _follower;

  // region Children Management

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _leader?.attach(owner);
    _follower?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _leader?.detach();
    _follower?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (_leader != null) visitor(_leader!);
    if (_follower != null) visitor(_follower!);
  }

  @override
  void setupParentData(RenderBox child) {
    child.parentData = _SimpleOverlayChild(child);
  }

  void insertRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _leader = child;
    } else {
      _follower = child;
    }
    adoptChild(child);
  }

  void moveRenderObjectChild(RenderBox child, bool oldSlot, bool newSlot) {
    if (oldSlot) {
      _leader = null;
    } else {
      _follower = null;
    }
    if (newSlot) {
      _leader = child;
    } else {
      _follower = child;
    }
  }

  void removeRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _leader = null;
    } else {
      _follower = null;
    }
    dropChild(child);
  }

  // endregion

  // region Layout

  @override
  void performLayout() {
    var followerConstraints = constraints;

    final leader = _leader;
    if (leader != null) {
      leader.layout(constraints, parentUsesSize: true);
      followerConstraints = BoxConstraints.tight(leader.size);
    }

    final follower = _follower;
    if (follower != null) {
      follower.layout(followerConstraints, parentUsesSize: true);
    }

    size = _leader?.size ?? _follower?.size ?? constraints.smallest;
  }

  // endregion

  // region Paint

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_leader != null) {
      context.paintChild(_leader!, offset);
    }
    if (_follower != null) {
      context.paintChild(_follower!, offset);
    }
  }

  // endregion

  // region Touch

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (_follower?.hitTest(result, position: position) == true) {
      return true;
    }
    if (_leader?.hitTest(result, position: position) == true) {
      return true;
    }
    return false;
  }

// endregion
}

// endregion
