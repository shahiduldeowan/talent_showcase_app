import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.label,
    this.height = 50.0,
    this.width = double.infinity,
  });

  final void Function() onPressed;
  final bool isLoading;
  final String label;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : Text(label),
      ),
    );
  }
}
