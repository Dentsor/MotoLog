import 'package:flutter/material.dart';

class RefuelAddPage extends StatefulWidget {
  const RefuelAddPage({super.key, required this.title});

  final String title;

  @override
  State<RefuelAddPage> createState() => _RefuelAddPageState();
}

class _RefuelAddPageState extends State<RefuelAddPage> {

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
