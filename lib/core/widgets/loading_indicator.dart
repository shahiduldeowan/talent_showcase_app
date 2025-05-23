import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
