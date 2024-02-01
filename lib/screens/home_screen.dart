import 'package:blocship/cubits/home_cubit.dart';
import 'package:blocship/screens/entry_screen.dart';
import 'package:blocship/states/home_screen_state.dart';
import 'package:blocship/widgets/chart_rep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/transaction_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of(context);
    homeCubit.loadTotalAmounts();

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
                                builder: (context) => EntryScreen(
                                      homeCubit: homeCubit,
                                    )),
                          );
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text("Add")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      } else if (state is HomeLoadedState) {
                        // Use state.totals to populate  UI
                        List<Map<String, dynamic>> pieData = [
                          {
                            'xData': 'Income',
                            'yData': state.totals['Income'] ?? 0,
                            'color': Colors.green,
                          },
                          {
                            'xData': 'Expense',
                            'yData': state.totals['Expense'] ?? 0,
                            'color': Colors.pink,
                          },
                          {
                            'xData': 'Saving',
                            'yData': state.totals['Saving']! < 0
                                ? 0
                                : state.totals['Saving']!,
                            'color': Colors.grey,
                          },
                        ];

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints.expand(
                                  height: 150, width: 200),
                              child: SfCircularChart(
                                centerY: '80',
                                margin: EdgeInsets.zero,
                                // borderWidth: 10,
                                series: <DoughnutSeries<Map<String, dynamic>,
                                    String>>[
                                  DoughnutSeries<Map<String, dynamic>, String>(
                                    explode: true,
                                    explodeOffset: "2%",
                                    explodeAll: true,
                                    innerRadius: '80%',
                                    radius:
                                        "${MediaQuery.of(context).size.height * 0.1}",
                                    dataSource: pieData,
                                    xValueMapper: (data, _) => data['xData'],
                                    yValueMapper: (data, _) => data['yData'],
                                    pointColorMapper: (data, _) =>
                                        data['color'],
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: false),
                                  ),
                                ],
                              ),
                              // ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                chartRep(color: Colors.pink, text: "Expense"),
                                const SizedBox(
                                  height: 10,
                                ),
                                chartRep(color: Colors.green, text: "Income"),
                                const SizedBox(
                                  height: 10,
                                ),
                                chartRep(color: Colors.grey, text: "Saving"),
                              ],
                            )
                          ],
                        );
                      } else if (state is HomeErrorState) {
                        return Center(
                          child: Text('Error: ${state.errorMessage}'),
                        );
                      } else {
                        return const Center(
                          child: Text('Data not available now'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state is HomeLoadedState) {
                  return ListView.builder(
                      itemCount: state.totals["transactionData"].length,
                      itemBuilder: (context, index) {
                        return transactionDetails(
                            context: context,
                            title: state.totals["transactionData"][index].title,
                            description: state
                                .totals["transactionData"][index].description,
                            entryType: state
                                .totals["transactionData"][index].entryType,
                            amount: state
                                .totals["transactionData"][index].amount
                                .toStringAsFixed(0)
                                .toString());
                      });
                } else {
                  return const SizedBox();
                }
              }),
            )
          ],
        ),
      ),
    ));
  }
}
