import 'package:flutter/material.dart';

Widget textInput({maxLimit,height,hintText}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(12.0),
    ),
    height: height,
    child: Center(
      child: TextFormField(
        // controller: context.read<EntryScreenBloc>().state.titleController,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          counterText: '', // Set counterText to an empty string
        ),
        maxLength: maxLimit,
      ),
    ),
  );
}
