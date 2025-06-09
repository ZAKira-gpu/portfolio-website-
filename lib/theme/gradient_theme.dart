import 'package:flutter/material.dart';

@immutable
class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient background;

  const GradientTheme({required this.background});

  @override
  GradientTheme copyWith({LinearGradient? background}) {
    return GradientTheme(
      background: background ?? this.background,
    );
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    return GradientTheme(
      background: LinearGradient.lerp(background, other.background, t)!,
    );
  }
}
