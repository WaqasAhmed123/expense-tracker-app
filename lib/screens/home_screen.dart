import 'package:blocship/cubits/home_cubit.dart';
import 'package:blocship/screens/entry_screen.dart';
import 'package:blocship/states/home_screen_state.dart';
import 'package:blocship/widgets/chart_rep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final HomeCubit homeCubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of(context);
    homeCubit.loadTotalAmounts();

    // HomeCubit homeCubit = HomeCubit();
    // homeCubit.loadTotalAmounts();

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
                      print("rebuilded");
                      // homeCubit.loadTotalAmounts();
                      // HomeCubit homeCubit = HomeCubit();
                      if (state is HomeLoadingState) {
                        print("checked first state");
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      } else if (state is HomeLoadedState) {
                        print("checked second state");

                        // Use state.totals to populate your UI
                        List<Map<String, dynamic>> pieData = [
                          {
                            'xData': 'Income',
                            'yData': state.totals['Income'] ?? 0
                          },
                          {
                            'xData': 'Expense',
                            'yData': state.totals['Expense'] ?? 0
                          },
                        ];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5, //
                              child: SfCircularChart(
                                centerY: '80',
                                margin: EdgeInsets.zero,
                                // borderWidth: 10,
                                series: <DoughnutSeries<Map<String, dynamic>,
                                    String>>[
                                  DoughnutSeries<Map<String, dynamic>, String>(
                                    // explode: true,
                                    // explodeIndex: 0,

                                    strokeWidth: 5,
                                    radius:
                                        "${MediaQuery.of(context).size.height * 0.1}",
                                    dataSource: pieData,
                                    xValueMapper: (data, _) => data['xData'],
                                    yValueMapper: (data, _) => data['yData'],
                                    // dataLabelMapper: (data, _) =>
                                    //     '${data['xData']}: ${data['yData']}',
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: false),
                                  ),
                                ],
                              ),
                            ),
                            // Column(
                            //   children: [
                            //     chartRep(color: Colors.pink, text: "Expnese"),
                            //     const SizedBox(
                            //       height: 10,
                            //     ),
                            //     chartRep(color: Colors.green, text: "Income"),
                            //   ],
                            // )
                          ],
                        );
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
    ));
  }
}
