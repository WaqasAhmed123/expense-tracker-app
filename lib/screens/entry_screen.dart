import 'package:blocship/widgets/textInput.dart';
import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

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
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
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
  }
}
