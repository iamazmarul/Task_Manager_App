import 'package:flutter/material.dart';

class CardSummary extends StatefulWidget {
  const CardSummary({
    super.key,
    required this.count,
    required this.title,
  });

  final String count, title;

  @override
  State<CardSummary> createState() => _CardSummaryState();
}

class _CardSummaryState extends State<CardSummary> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            Text(
              widget.count,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}