import 'package:flutter/material.dart';

Widget textInput(
    {maxLimit,
    height,
    hintText,
    context,
    readOnly = false,
    showCursor,
    contoller}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(12.0),
    ),
    height: height,
    child: Center(
      child: TextFormField(
        showCursor: showCursor,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: contoller,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          hintText: hintText,
          border: InputBorder.none,
          counterText: '', // Set counterText to an empty string
        ),
        maxLength: maxLimit,
        readOnly: readOnly,
      ),
    ),
  );
}
