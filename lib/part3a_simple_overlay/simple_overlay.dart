import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// region SimpleOverlay

class SimpleOverlay extends MultiChildRenderObjectWidget {
  SimpleOverlay({
    required Widget child,
    required Widget overlay,
  }) : super(children: [child, overlay]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSimpleOverlay();
  }
}

// endregion

// region SimpleOverlayChild

class _SimpleOverlayChild extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}

// endregion

// region SimpleOverlayRenderObject

class RenderSimpleOverlay extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _SimpleOverlayChild>,
        RenderBoxContainerDefaultsMixin<RenderBox, _SimpleOverlayChild> {
  // region Children Management

  @override
  void setupParentData(covariant RenderObject child) {
    child.parentData = _SimpleOverlayChild();
  }

  // endregion

  // region Layout

  @override
  void performLayout() {
    var childConstraints = constraints;

    final child = firstChild;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      childConstraints = BoxConstraints.tight(child.size);
    }

    final overlay = (child == null) ? null : childAfter(child);
    if (overlay != null) {
      overlay.layout(childConstraints, parentUsesSize: true);
    }

    size = child?.size ?? overlay?.size ?? constraints.smallest;
  }

  // endregion

  // region Paint

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  // endregion

  // region Touch

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

// endregion
}

// endregion
