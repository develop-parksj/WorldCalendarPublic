import 'dart:math';

import 'package:flutter/material.dart';
import 'package:world_calendar/style/color_style.dart';

class TextStyleBlack14w extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleBlack14w({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designBlack.withAlpha((255 * opacity).toInt()),
      size: 14,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleBlack16 extends StatelessWidget {
  final String text;
  final int maxLines;
  final double opacity;

  const TextStyleBlack16({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designBlack.withAlpha((255 * opacity).toInt()),
      size: 16,
      maxLines: maxLines,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleBlack20 extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleBlack20({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designBlack.withAlpha((255 * opacity).toInt()),
      size: 20,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleBlack22w extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleBlack22w({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designBlack.withAlpha((255 * opacity).toInt()),
      size: 22,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleWhite18 extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleWhite18({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designWhite.withAlpha((255 * opacity).toInt()),
      size: 18,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleWhite22 extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleWhite22({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designWhite.withAlpha((255 * opacity).toInt()),
      size: 22,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleWhite22w extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleWhite22w({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designWhite.withAlpha((255 * opacity).toInt()),
      size: 22,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleGrey9 extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleGrey9({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designGrey.withAlpha((255 * opacity).toInt()),
      size: 9,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleIndigo18 extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleIndigo18({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designIndigo.withAlpha((255 * opacity).toInt()),
      size: 18,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleIndigo22w extends StatelessWidget {
  final String text;
  final double opacity;

  const TextStyleIndigo22w({
    super.key,
    required this.text,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: ColorStyle.designIndigo.withAlpha((255 * opacity).toInt()),
      size: 22,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleColor9 extends StatelessWidget {
  final String text;
  final Color color;
  final double opacity;

  const TextStyleColor9({
    super.key,
    required this.text,
    required this.color,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: color.withAlpha((255 * opacity).toInt()),
      size: 9,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleColor18w extends StatelessWidget {
  final String text;
  final Color color;
  final double opacity;

  const TextStyleColor18w({
    super.key,
    required this.text,
    required this.color,
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: color.withAlpha((255 * opacity).toInt()),
      size: 18,
      fontWeight: FontWeight.w700,
    );
  }
}

class TextStyleColor18 extends StatelessWidget {
  final String text;
  final Color color;
  final double opacity;
  final TextAlign? textAlign;

  const TextStyleColor18({
    super.key,
    required this.text,
    required this.color,
    this.opacity = 1,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextStyleBase(
      text: text,
      color: color.withAlpha((255 * opacity).toInt()),
      size: 18,
      textAlign: textAlign,
      fontWeight: FontWeight.normal,
    );
  }
}

class TextStyleBase extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLength;
  final int? maxLines;

  const TextStyleBase({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.fontWeight,
    this.textAlign,
    this.maxLength,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return text.isNotEmpty ? maxLines != 1 ? Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      textScaler: TextScaler.linear(1.0),
      style: TextStyle(
        height: text.contains('\n') ? 1 : null,
        color: color,
        fontFamily: 'Noto Sans CJK JP',
        fontSize: size,
        fontWeight: fontWeight,
      ),
    ) : SingleLineText(
      text: text,
      color: color,
      size: size,
      fontWeight: fontWeight,
      textAlign: textAlign,
    ) : const SizedBox.shrink();
  }
}


class SingleLineText extends StatefulWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const SingleLineText({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.fontWeight,
    this.textAlign,
  });

  @override
  createState() => SingleLineTextState();
}

class SingleLineTextState extends State<SingleLineText> {
  String? _textCache;

  @override
  void didUpdateWidget(covariant SingleLineText oldWidget) {
    if (widget.text != oldWidget.text) {
      _textCache = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // 初回 build 時に計算して結果をキャッシュする
      _textCache ??= TextTruncator(
        TextStyle(
          height: widget.text.contains('\n') ? 1 : null,
          color: widget.color,
          fontFamily: 'Noto Sans CJK JP',
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
        ),
        Directionality.maybeOf(context),
      ).truncateTextForWidth(widget.text, constraints.maxWidth);
      return Text(
        _textCache!,
        maxLines: 1,
        textAlign: widget.textAlign ?? TextAlign.start,
        overflow: TextOverflow.visible,
        textScaler: TextScaler.linear(1.0),
        style: TextStyle(
          height: widget.text.contains('\n') ? 1 : null,
          color: widget.color,
          fontFamily: 'Noto Sans CJK JP',
          fontSize: widget.size,
          fontWeight: widget.fontWeight,
        ),
      );
    });
  }
}

class TextTruncator {
  const TextTruncator(this.style, this.textDirection, {this.ellipsisText = '...'});

  final TextStyle style;
  final TextDirection? textDirection;
  final String ellipsisText;

  /// [text]をレンダリングした時の幅を調べます
  double _getTextWidth(String text) {
    final painter = TextPainter(
      maxLines: 1,
      textDirection: textDirection ?? TextDirection.ltr,
      text: TextSpan(text: text, style: style),
    );
    painter.layout();
    return painter.width;
  }

  /// [text]の先頭から長さ[length]切り出したときのレンダリング幅を調べます
  double _getSubstringWidth(String text, int length) {
    return _getTextWidth(text.substring(0, length));
  }

  /// [text]が指定された[maxWidth]に収まるように文字列を切り捨てます。
  String truncateTextForWidth(String text, double maxWidth) {
    if (maxWidth == double.infinity || maxWidth < 0) {
      return text;
    }

    final width = _getTextWidth(text);
    if (width <= maxWidth) {
      return text;
    }

    /// テキストボックスに収まらない場合は maxWidth から ellipsisText 分減らした幅を目標とします。
    final limit = maxWidth - _getTextWidth(ellipsisText);

    /// ellipsisText すら収まらない場合は諦めて空文字列を返します。
    if (limit <= 0) {
      return '';
    }

    /// まず maxWidth に収まりそうなだいたいのテキスト長に検討をつけてレンダリング幅を計測します。
    int pos = max(1, (text.length * (maxWidth / width)).toInt());
    final measured = _getSubstringWidth(text, pos);

    if (measured > limit) {
      // レンダリング幅の方がlimitより大きい場合、
      // 1文字づつ減らしながら、レンダリング幅がlimit以下になる場所を探します。
      while (pos > 0) {
        pos--;
        if (_getSubstringWidth(text, pos) <= limit) break;
      }
      return text.substring(0, pos) + ellipsisText;
    } else {
      // レンダリング幅のがlimit以下の場合
      // 1文字づつ増やしながら、レンダリング幅がlimit以上になる場所を探します。
      while (pos < text.length) {
        pos++;
        if (_getSubstringWidth(text, pos) > limit) break;
      }
      return text.substring(0, pos - 1) + ellipsisText;
    }
  }
}