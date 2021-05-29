import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// region OverflowToolbar

class OverflowToolbar extends RenderObjectWidget {
  final List<Icon> icons;

  const OverflowToolbar({required this.icons});

  @override
  RenderObjectElement createElement() {
    return OverflowToolbarElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return OverflowToolbarRender(context as OverflowToolbarElement);
  }
}

// endregion

// region OverflowToolbarElement

class OverflowToolbarElement extends RenderObjectElement {
  final _children = <Element?>[];

  OverflowToolbarElement(OverflowToolbar widget) : super(widget);

  @override
  OverflowToolbar get widget {
    return super.widget as OverflowToolbar;
  }

  @override
  OverflowToolbarRender get renderObject {
    return super.renderObject as OverflowToolbarRender;
  }

  @override
  void update(OverflowToolbar newWidget) {
    super.update(newWidget);

    // for (final index in _children.keys.toList()) {
    //   _children[index] = updateChild(_children[index], newWidget.icons[index], index);
    // }
  }

  @override
  void unmount() {
    super.unmount();
    _children.clear();
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    // for (final child in _children.values) {
    //   if (child != null) visitor(child);
    // }
  }

  @override
  void forgetChild(Element child) {
    super.forgetChild(child);
    // _children.removeWhere((key, value) => value == child);
  }

  @override
  void insertRenderObjectChild(RenderBox child, int slot) {
    renderObject.insertRenderObjectChild(child, slot);
  }

  @override
  void removeRenderObjectChild(RenderBox child, int slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }

  void requestItem(int index) {
    _children[index] = updateChild(_children[index], widget.icons[index], index);
  }

  void removeItemsAfter(int index) {
    final child = _children[index];
    if (child != null) {
      forgetChild(child);
    }
  }
}

// endregion

// region OverflowToolbarChild

class OverflowToolbarChild extends BoxParentData {
  final RenderBox renderBox;

  var index = -1;

  OverflowToolbarChild(this.renderBox);
}

// endregion

// region OverflowToolbarRender

class OverflowToolbarRender extends RenderBox {
  final OverflowToolbarElement _element;
  final _children = <OverflowToolbarChild>[];

  OverflowToolbarRender(this._element);

  // region Children Management

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    for (final child in _children) {
      child.renderBox.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();

    for (final child in _children) {
      child.renderBox.detach();
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    for (final child in _children) {
      visitor(child.renderBox);
    }
  }

  @override
  void setupParentData(RenderBox child) {
    child.parentData = OverflowToolbarChild(child);
  }

  void allowMutationsLock<T>(void block()) {
    invokeLayoutCallback((_) {
      _element.owner?.buildScope(_element, block);
    });
  }

  void insertRenderObjectChild(RenderBox child, int slot) {
    adoptChild(child);
    insertChild(child);
  }

  void removeRenderObjectChild(RenderBox child, int slot) {
    dropChild(child);
    _children.removeWhere((element) => element.index == slot);
  }

  void insertChild(RenderBox renderBox) {
    final child = renderBox.parentData as OverflowToolbarChild;
    final index = _children.lowerBoundBy<num>(child, (value) => value.index);
    _children.insert(index, child);
  }

  // endregion

  // region Layout

  @override
  void performLayout() {}

  // endregion

  // region Paint

  @override
  void paint(PaintingContext context, Offset offset) {}

  // endregion

  // region HitTest

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return super.hitTestChildren(result, position: position);
  }

// endregion

}

// endregion
