import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget transactionDetails(
    {icon,
    Color? iconColor,
    title,
    description,
    date,
    time,
    amount,
    context,
    entryType}) {
  return Card(
      color: Colors.white,
      elevation: 5, // Set the elevation (shadow) of the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Set border radius
        side: const BorderSide(
            color: Colors.transparent,
            width: 2.0), // Set border color and width
      ),
      child: ListTile(
        // horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.only(right: 16),
        // minLeadingWidth: 0,
        // visualDensity: const VisualDensity(vertical: 0),
        leading: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.withOpacity(0.3),
          child: Icon(
            entryType == "Income"
                ? CupertinoIcons.arrow_right
                : CupertinoIcons.arrow_left,
            color: entryType == "Income" ? Colors.green : Colors.red,
            // icon,
            // color:Color(iconColor) ,
          ),
        ),
        title: Align(
          alignment: const Alignment(-1.2, 0),
          child: Text(title,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 16,
              )),
        ),
        subtitle: Align(
          alignment: const Alignment(-1.4, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        ),
        trailing: Text(amount,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 16,
            )),
      )
      //  Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         CircleAvatar(
      //           backgroundColor: Colors.grey.withOpacity(0.5),
      //           child: Icon(
      //             icon,
      //             color: iconColor,
      //           ),
      //         )
      //       ],
      //     ),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Text(title,
      //             style: TextStyle(
      //               color: Colors.black.withOpacity(0.8),
      //               fontSize: 16,
      //             )),
      //         Text(
      //           description,
      //           style: Theme.of(context).textTheme.bodyMedium,
      //         ),
      //         Text(
      //           "$date at $time",
      //           style: TextStyle(
      //             fontSize: 12,
      //             color: Colors.grey.withOpacity(0.5),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Text(amount,
      //             style: TextStyle(
      //               color: Colors.black.withOpacity(0.8),
      //               fontSize: 16,
      //             ))
      //       ],
      //     )
      //   ],
      // ),
      );
}
