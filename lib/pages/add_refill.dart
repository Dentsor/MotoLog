import 'package:flutter/material.dart';

class AddRefillPage extends StatefulWidget {
  const AddRefillPage({super.key, required this.title});

  final String title;

  @override
  State<AddRefillPage> createState() => _AddRefillPageState();
}

class _AddRefillPageState extends State<AddRefillPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("Add page"),
      ),
    );
  }
}
