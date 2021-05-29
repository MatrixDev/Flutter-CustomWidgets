import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// region FollowLeader

class FollowLeader extends RenderObjectWidget {
  final Widget leader;
  final Widget follower;

  const FollowLeader({
    required this.leader,
    required this.follower,
  });

  @override
  RenderObjectElement createElement() {
    return FollowLeaderElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return FollowLeaderRenderObject();
  }
}

// endregion

// region FollowLeaderElement

class FollowLeaderElement extends RenderObjectElement {
  Element? _leader;
  Element? _follower;

  FollowLeaderElement(FollowLeader widget) : super(widget);

  @override
  FollowLeader get widget {
    return super.widget as FollowLeader;
  }

  @override
  FollowLeaderRenderObject get renderObject {
    return super.renderObject as FollowLeaderRenderObject;
  }

  @override
  void mount(Element? parent, newSlot) {
    super.mount(parent, newSlot);

    _leader = inflateWidget(widget.leader, true);
    _follower = inflateWidget(widget.follower, false);
  }

  @override
  void update(FollowLeader newWidget) {
    super.update(newWidget);

    _leader = updateChild(_leader, newWidget.leader, true);
    _follower = updateChild(_follower, newWidget.follower, false);
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

// region FollowLeaderChild

class _FollowLeaderChild extends BoxParentData {
  final RenderBox renderBox;
  final activePointers = <int>{};

  var hitTestResult = BoxHitTestResult();

  _FollowLeaderChild(this.renderBox);
}

// endregion

// region FollowLeaderRenderObject

class FollowLeaderRenderObject extends RenderBox {
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
    child.parentData = _FollowLeaderChild(child);
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
