// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DopePanel extends StatelessWidget {
  final String? headline;
  final Widget? child;
  const DopePanel({Key? key, this.headline = '', this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline!,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 16),
        child == null ? SizedBox() : child!
      ],
    );
  }
}
