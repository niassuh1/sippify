import 'package:flutter/material.dart';

enum DescriptionPanelStyle {
  Style1,
  Style2,
}

class DescriptionPanel extends StatelessWidget {
  final String? title;
  final String? description;
  late DescriptionPanelStyle? panelStyle = DescriptionPanelStyle.Style1;
  DescriptionPanel(
      {Key? key,
      this.title = '',
      this.description = '',
      this.panelStyle = DescriptionPanelStyle.Style1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (panelStyle) {
      case DescriptionPanelStyle.Style1:
        return _DescriptionPanel1(
          title: title,
          description: description,
        );
      case DescriptionPanelStyle.Style2:
        return _DescriptionPanel2(
          title: title,
          description: description,
        );
      default:
        return _DescriptionPanel1(
          title: title,
          description: description,
        );
    }
  }
}

class _DescriptionPanel1 extends StatelessWidget {
  final String? title;
  final String? description;
  _DescriptionPanel1({this.title = '', this.description = ''});

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

class _DescriptionPanel2 extends StatelessWidget {
  final String? title;
  final String? description;
  _DescriptionPanel2({this.title = '', this.description = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title!.toUpperCase(),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 11.5,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          description!,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
