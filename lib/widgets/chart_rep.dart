import 'package:flutter/material.dart';

chartRep({required Color color, text}) {
  return Row(
    children: [
      CircleAvatar(
        radius: 10,
        backgroundColor: color,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(text),
      )
    ],
  );
}
