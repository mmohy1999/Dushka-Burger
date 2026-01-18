import 'package:flutter/material.dart';

class HomePlaceholderPage extends StatelessWidget {
  final String label;

  const HomePlaceholderPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
