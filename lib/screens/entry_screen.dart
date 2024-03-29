import 'package:blocship/cubits/entry_cubit.dart';
import 'package:blocship/states/entry_screen_state.dart';
import 'package:blocship/widgets/textInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key, this.homeCubit});
  final homeCubit;

  @override
  Widget build(BuildContext context) {
    EntryCubit entryCubit = BlocProvider.of(context);
    TextEditingController amountController =
        TextEditingController(text: entryCubit.amount);
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: entryCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      textInput(
                        maxLimit: 30,
                        height: 40.0,
                        hintText: 'Title',
                        context: context,
                        contoller: entryCubit.titleController,
                        onChanged: (value) {
                          entryCubit.updateButtonState();
                          // entryCubit.titleController.text = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      textInput(
                        maxLimit: 100,
                        height: 90.0,
                        hintText: "Description",
                        context: context,
                        contoller: entryCubit.descriptionController,
                        onChanged: (value) {
                          entryCubit.updateButtonState();
                        },
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
                                  // print(entryCubit.dateController);
                                  if (picked != null &&
                                      picked != entryCubit.selectedDate) {
                                    entryCubit.datePicked(
                                        selectedDateNew: picked);
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
                                  entryCubit.timePicked(
                                      selectedTimeNew: pickedTime);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: textInput(
                                height: 40.0,
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
                          entryCubit.entryType = value!;
                          print(entryCubit.entryType);
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        value: "Expense",
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffffffff),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            isDense: true),
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
                      textInput(
                        context: context,
                        contoller: amountController,
                        readOnly: true,
                        showCursor: true,
                        hintText: "Amount",
                      ),
                      NumericKeyboard(
                          onKeyboardTap: (value) {
                            entryCubit.onKeyboardTap(
                                value: value,
                                amountController: amountController);
                            entryCubit.updateButtonState();
                          },
                          textStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.black),
                          rightButtonFn: () {
                            entryCubit.rightButtonFn(
                                amountController: amountController);
                          },
                          rightIcon: GestureDetector(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          backgroundColor: entryCubit.isButtonEnabled
                              ? Colors.blue
                              : Colors.grey,
                          shape: const CircleBorder(),
                          onPressed: entryCubit.isButtonEnabled
                              ? () async {
                                  await entryCubit.sendEntry(
                                      homeCubit: homeCubit,
                                      date: dateController.text,
                                      time: timeController.text,
                                      amount: amountController.text);
                                  dateController.clear();
                                  timeController.clear();
                                  amountController.clear();
                                  entryCubit.amount = "";

                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                }
                              : null,
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
