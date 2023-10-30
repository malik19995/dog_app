import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';

class TestAppWidget extends StatefulWidget {
  final Widget _child;

  const TestAppWidget({required Widget child, Key? key})
      : _child = child,
        super(key: key);

  @override
  State<TestAppWidget> createState() => _TestAppWidgetState();
}

class _TestAppWidgetState extends State<TestAppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Layout(child: widget._child),
    );
  }
}
