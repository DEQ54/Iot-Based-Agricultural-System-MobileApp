import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconContent extends StatelessWidget {
  const IconContent(
      {@required this.icon, @required this.label, this.color = Colors.black});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 50.0,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
          ),
        ),
      ],
    );
  }
}
