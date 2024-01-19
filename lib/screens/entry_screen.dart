import 'package:blocship/cubits/entry_cubit.dart';
import 'package:blocship/states/entry_screen_state.dart';
import 'package:blocship/widgets/textInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EntryCubit entryCubit = BlocProvider.of(context);
    return BlocBuilder<EntryCubit, EntryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Expense Entry'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                textInput(maxLimit: 30, height: 40.0, hintText: 'Title'),
                const SizedBox(height: 16),
                textInput(maxLimit: 100, height: 90.0, hintText: "Description"),
                // const TextField(
                //   // controller: context.read<EntryScreenBloc>().state.titleController,
                //   decoration: InputDecoration(labelText: 'Title (30 characters)'),
                //   maxLength: 30,
                // ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: entryCubit.selectedDate,
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));
                        if (picked != null && picked != entryCubit.selectedDate) {
                          
                          // setState(() {
                          //   selectedDate = picked;
                          // }
                          // );
                        }
                        // Show date picker and update the state
                      },
                    ),
                    const Expanded(
                      child: TextField(
                        // controller: context.read<EntryScreenBloc>().state.dateController,
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'Date'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () {
                        // Show time picker and update the state
                      },
                    ),
                    const Expanded(
                      child: TextField(
                        // controller: context.read<EntryScreenBloc>().state.timeController,
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'Time'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // DropdownButton<String>(
                //   value: "example",
                //   onChanged: (String? newValue) {
                //      newValue!;
                //   // value: context.read<EntryScreenBloc>().state.selectedCategory,
                //   // onChanged: (String? newValue) {
                //   //   context.read<EntryScreenBloc>().state.selectedCategory = newValue!;
                //   },
                //   items: ['Expense', 'Income'].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
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
