import 'package:flutter/material.dart';

class Bag extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;
  const Bag({super.key, required this.child, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color ?? Theme.of(context).colorScheme.secondary),
              constraints: const BoxConstraints(maxHeight: 16, minHeight: 16),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ))
      ],
    );
  }
}
