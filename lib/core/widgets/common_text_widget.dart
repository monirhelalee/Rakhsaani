import 'package:flutter/material.dart';
import '../utils/utils_exports.dart';

class CommonTextWidget extends Text {
  CommonTextWidget(
    String data, {
    Key? key,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticLabel,
    TextStyle? style,
  }) : super(
          data,
          key: key,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticLabel,
          style: style ?? AppTextStyles.regular14,
        );
}
