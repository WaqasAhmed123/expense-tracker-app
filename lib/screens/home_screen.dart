import 'package:blocship/cubits/home_cubit.dart';
import 'package:blocship/screens/entry_screen.dart';
import 'package:blocship/states/home_screen_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<_PieData> pieData = [_PieData("Income", 660)];
    [_PieData("Expense", 66)];
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EntryScreen()),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text("Add")),
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is HomeLoadedState) {
                        // Use state.totals to populate your UI
                        return SfCircularChart(
                            // title: const ChartTitle(text: 'Sales by sales person'),
                            // legend: const Legend(isVisible: true),
                            series: <DoughnutSeries<_PieData, String>>[
                              DoughnutSeries<_PieData, String>(
                                  explode: true,
                                  explodeIndex: 0,
                                  radius:
                                      "${MediaQuery.sizeOf(context).height * 0.1}",
                                  dataSource: pieData,
                                  xValueMapper: (_PieData data, _) =>
                                      data.xData,
                                  yValueMapper: (_PieData data, _) =>
                                      data.yData,
                                  dataLabelMapper: (_PieData data, _) =>
                                      data.text,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true)),
                            ]);
                      } else if (state is HomeErrorState) {
                        return Center(
                          child: Text('Error: ${state.errorMessage}'),
                        );
                      } else {
                        return const Center(
                          child: Text('Unknown state'),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )

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
