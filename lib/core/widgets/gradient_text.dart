import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback:
          (Rect bounds) => gradient.createShader(
            Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
          ),
      child: Text(text, style: style?.copyWith(color: Colors.white)),
    );
  }
}
