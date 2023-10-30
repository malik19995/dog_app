import 'package:dog_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A custom wrapper on Text Widget.

class AppText extends ConsumerWidget {
  final String text;
  final String variant;
  final Color color;
  final TextAlign textAlign;
  final double? lineHeight;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLines;

  const AppText(
    this.text, {
    this.color = Colors.white,
    this.variant = 'bodyMedium',
    this.textAlign = TextAlign.start,
    this.padding = EdgeInsets.zero,
    this.maxLines,
    this.lineHeight,
    this.fontWeight,
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider).current.themeData;

    TextStyle textStyle;
    switch (variant) {
      case 'titleMedium':
        textStyle = appTheme.textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        );
      case 'titleLarge':
        textStyle = appTheme.textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        );
      case 'bodyMedium':
        textStyle = appTheme.textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        );
      case 'bodyLarge':
        textStyle = appTheme.textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 18,
        );
      case 'bodySmall':
        textStyle = appTheme.textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
        );
      default:
        textStyle = appTheme.textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
        );
    }
    return Padding(
      padding: padding!,
      child: Text(
        text,
        style: textStyle.copyWith(
          height: lineHeight,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );
  }
}
