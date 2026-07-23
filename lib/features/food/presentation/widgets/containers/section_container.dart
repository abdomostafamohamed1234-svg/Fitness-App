import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final TextStyle? style;
  const SectionContainer({
    super.key,
    required this.child,
    required this.title,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: style),
        ),
        child,
      ],
    );
  }
}
