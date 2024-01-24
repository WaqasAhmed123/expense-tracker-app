import 'dart:math' as Math;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<_PieData> pieData = 
    [_PieData("Income", 660)];
    [_PieData("Expense", 660)];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doughnut Chart Screen'),
        ),
        body: SfCircularChart(
            title: const ChartTitle(text: 'Sales by sales person'),
            legend: const Legend(isVisible: true),
            series: <PieSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                  explode: true,
                  explodeIndex: 0,
                  dataSource: pieData,
                  xValueMapper: (_PieData data, _) => data.xData,
                  yValueMapper: (_PieData data, _) => data.yData,
                  dataLabelMapper: (_PieData data, _) => data.text,
                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
            ])

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     // Doughnut Chart
        //     SizedBox(
        //       height: MediaQuery.of(context).size.height * 0.3,
        //       child: FutureBuilder(
        //         future: fetchDataFromFirebase(), // Your function to fetch data
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return const CircularProgressIndicator();
        //           } else if (snapshot.hasError) {
        //             return Text('Error: ${snapshot.error}');
        //           } else {
        //             List<double> data = snapshot.data as List<double>;
        //             return Padding(
        //               padding: const EdgeInsets.all(16.0),
        //               child: PieChart(
        //                 PieChartData(
        //                   sections: List.generate(
        //                     data.length,
        //                     (index) => PieChartSectionData(
        //                       color: getRandomColor(),
        //                       value: data[index],
        //                       title: '${data[index].toStringAsFixed(1)}%',
        //                       radius: 60,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           }
        //         },
        //       ),
        //     ),

        //     // Add Button
        //     Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Add button functionality here
        //         },
        //         child: const Text('Add'),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }

  Future<List<double>> fetchDataFromFirebase() async {
    // Fetch data from Firebase (replace with your logic)
    // Example: Fetch a collection of values from Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Entries').get();

    // Extract values from documents
    List<double> data = querySnapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['amount'] as double)
        .toList();

    return data;
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}
