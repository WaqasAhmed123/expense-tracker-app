import 'package:flutter/material.dart';

chartRep({required Color color, text}) {
  return Row(
    children: [
      Column(
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: color,
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      )
    ],
  );
}
