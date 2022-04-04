import 'package:flutter/material.dart';

class DescriptionPanel extends StatelessWidget {
  final String? title;
  final String? description;
  const DescriptionPanel({Key? key, this.title = '', this.description = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black26, fontWeight: FontWeight.w500, fontSize: 13),
        ),
        Text(
          description!,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
