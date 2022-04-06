import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  IconData icon;
  Function()? onPressed;

  CustomIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: IconButton(
        splashRadius: 24,
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
