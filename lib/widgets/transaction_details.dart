import 'package:flutter/material.dart';

Widget transactionDetails(
    {icon, iconColor, title, description, date, time, amount, context}) {
  return Card(
    elevation: 5, // Set the elevation (shadow) of the card
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Set border radius
      side: const BorderSide(
          color: Colors.transparent, width: 2.0), // Set border color and width
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: Icon(
                icon,
                color: iconColor,
              ),
            )
          ],
        ),
        Column(
          children: [
            Text(title,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 16,
                )),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "$date at $time",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(amount,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 16,
                ))
          ],
        )
      ],
    ),
  );
}
