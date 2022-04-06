// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

enum HeadlineSize {
  Small,
  Regular,
}

class DopePanel extends StatelessWidget {
  final String? headline;
  final Widget? child;
  final HeadlineSize? headlineSize;
  const DopePanel({Key? key, this.headline = '', this.child, this.headlineSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline!,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: getHeadlineSize(context)),
        ),
        SizedBox(height: 16),
        child == null ? SizedBox() : child!
      ],
    );
  }

  double? getHeadlineSize(BuildContext context) {
    switch (headlineSize) {
      case HeadlineSize.Small:
        return 16;
      case HeadlineSize.Regular:
        return Theme.of(context).textTheme.headline1!.fontSize;
      default:
        return Theme.of(context).textTheme.headline1!.fontSize;
    }
  }
}
