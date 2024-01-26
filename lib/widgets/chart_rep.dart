import 'package:flutter/material.dart';

chartRep({required Color color,text}){
  return Row(
    children: [
      CircleAvatar(
        radius: 10,
        backgroundColor: color,
      ),
      Text(text)
    ],
  );
}