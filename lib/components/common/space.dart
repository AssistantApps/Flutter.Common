import 'package:flutter/material.dart';

class EmptySpace extends StatelessWidget {
  final double multiplier;

  const EmptySpace(this.multiplier, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(multiplier * 4));
  }
}

class EmptySpace1x extends StatelessWidget {
  const EmptySpace1x({super.key});

  @override
  Widget build(BuildContext context) => const EmptySpace(1.0);
}

class EmptySpace2x extends StatelessWidget {
  const EmptySpace2x({super.key});

  @override
  Widget build(BuildContext context) => const EmptySpace(2.0);
}

class EmptySpace3x extends StatelessWidget {
  const EmptySpace3x({super.key});

  @override
  Widget build(BuildContext context) => const EmptySpace(3.0);
}

class EmptySpace8x extends StatelessWidget {
  const EmptySpace8x({super.key});

  @override
  Widget build(BuildContext context) => const EmptySpace(8.0);
}

class EmptySpace10x extends StatelessWidget {
  const EmptySpace10x({super.key});

  @override
  Widget build(BuildContext context) => const EmptySpace(10.0);
}
