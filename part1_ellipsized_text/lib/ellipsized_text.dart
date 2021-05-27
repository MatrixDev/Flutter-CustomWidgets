import 'package:flutter/widgets.dart';

enum Ellipsis { start, middle, end }

class EllipsizedText extends LeafRenderObjectWidget {
  final String text;
  final TextStyle? style;
  final Ellipsis ellipsis;

  const EllipsizedText(
    this.text, {
    Key? key,
    this.style,
    this.ellipsis = Ellipsis.end,
  }) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderEllipsizedText()..widget = this;
  }

  @override
  void updateRenderObject(BuildContext context, RenderEllipsizedText renderObject) {
    renderObject.widget = this;
  }
}

class RenderEllipsizedText extends RenderBox {
  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  var _widgetChanged = false;
  var _widget = const EllipsizedText('');
  var _constraints = const BoxConstraints();

  set widget(EllipsizedText widget) {
    if (_widget.text == widget.text &&
        _widget.style == widget.style &&
        _widget.ellipsis == widget.ellipsis) {
      return;
    }
    _widgetChanged = true;
    _widget = widget;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    if (!_widgetChanged && _constraints == constraints && hasSize) {
      return;
    }

    _widgetChanged = false;
    _constraints = constraints;

    size = _ellipsize(
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }

  Size _ellipsize({required double minWidth, required double maxWidth}) {
    final text = _widget.text;

    if (_layoutText(length: text.length, minWidth: minWidth) > maxWidth) {
      var left = 0;
      var right = text.length - 1;

      while (left < right) {
        final index = (left + right) ~/ 2;
        if (_layoutText(length: index, minWidth: minWidth) > maxWidth) {
          right = index;
        } else {
          left = index + 1;
        }
      }
      _layoutText(length: right - 1, minWidth: minWidth);
    }

    return constraints.constrain(Size(_textPainter.width, _textPainter.height));
  }

  double _layoutText({required int length, required double minWidth}) {
    final text = _widget.text;
    final style = _widget.style;
    final ellipsis = _widget.ellipsis;

    String ellipsizedText = '';

    switch (ellipsis) {
      case Ellipsis.start:
        if (length > 0) {
          ellipsizedText = text.substring(text.length - length, text.length);
          if (length != text.length) {
            ellipsizedText = '...' + ellipsizedText;
          }
        }
        break;
      case Ellipsis.middle:
        if (length > 0) {
          ellipsizedText = text;
          if (length != text.length) {
            var start = text.substring(0, (length / 2).round());
            var end = text.substring(text.length - start.length, text.length);
            ellipsizedText = start + '...' + end;
          }
        }
        break;
      case Ellipsis.end:
        if (length > 0) {
          ellipsizedText = text.substring(0, length);
          if (length != text.length) {
            ellipsizedText = ellipsizedText + '...';
          }
        }
        break;
    }

    _textPainter.text = TextSpan(text: ellipsizedText, style: style);
    _textPainter.layout(minWidth: minWidth, maxWidth: double.infinity);
    return _textPainter.width;
  }
}
