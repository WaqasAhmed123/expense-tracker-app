import 'package:blocship/cubits/entry_cubit.dart';
import 'package:blocship/states/entry_screen_state.dart';
import 'package:blocship/widgets/textInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // EntryCubit entryCubit = EntryCubit.get(context);
    EntryCubit entryCubit = BlocProvider.of(context);
    return BlocBuilder<EntryCubit, EntryState>(
      builder: (context, state) {
        TextEditingController dateController = TextEditingController(
          text: DateFormat('dd MMM yyyy').format(entryCubit.selectedDate),
        );
        TextEditingController timeController = TextEditingController(
          text: DateFormat('h:mm a').format(DateTime(2022, 1, 1,
              entryCubit.selectedTime.hour, entryCubit.selectedTime.minute)),
        );
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expense Entry'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                textInput(
                    maxLimit: 30,
                    height: 40.0,
                    hintText: 'Title',
                    context: context),
                const SizedBox(height: 16),
                textInput(
                    maxLimit: 100,
                    height: 90.0,
                    hintText: "Description",
                    context: context),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: entryCubit.selectedDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            print(entryCubit.dateController);
                            if (picked != null &&
                                picked != entryCubit.selectedDate) {
                              entryCubit.datePicked(selectedDateNew: picked);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: textInput(
                          height: 40.0,
                          hintText: "Date",
                          readOnly: true,
                          context: context,
                          contoller: dateController),
                    ),
                    // const Expanded(
                    //   child: TextField(
                    //     // controller:entryCubit,
                    //     // controller: TextEditingController(
                    //     //     text: DateFormat('dd MMM yyyy')
                    //     //         .format(entryCubit.selectedDate)),
                    //     readOnly: true,
                    //     decoration: InputDecoration(labelText: 'Date'),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        color: Colors.grey,
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: entryCubit.selectedTime,
                            context: context,
                          );
                          if (pickedTime != entryCubit.selectedTime) {
                            entryCubit.timePicked(selectedTimeNew: pickedTime);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: textInput(
                          hintText: 'Time',
                          readOnly: true,
                          context: context,
                          contoller: timeController),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  onChanged: (value) {
                    entryCubit.transactionType = value;
                    print(entryCubit.transactionType);
                  },
                  style: Theme.of(context).textTheme.bodyMedium,
                  // value: "selectedOptions",
                  value: "Expense",
                  validator: (value) {
                    if (value == null) {
                      return ("Field can't be null");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      // hintText: "hintText",
                      // hintStyle: TextStyle(
                      //   fontSize: 13.0,
                      //   // fontFamily: "Poppins",
                      //   color: const Color(0xff0e0e0e).withOpacity(0.3),
                      //   fontWeight: FontWeight.w500,
                      // ),
                      fillColor: const Color(0xffffffff),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 16)),
                  items: ["Expense", "Income"]
                      .map<DropdownMenuItem<String>>((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        key,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: TextEditingController(),
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
