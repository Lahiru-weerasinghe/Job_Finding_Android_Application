import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
