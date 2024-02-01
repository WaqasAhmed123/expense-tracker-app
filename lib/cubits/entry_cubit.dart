import 'package:blocship/services/firebase_service.dart';
import 'package:blocship/states/entry_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/entries_model.dart';

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryInitialState());
  // var homeCubit;

//  EntryCubit= BlocProvider.of(context)
  // HomeCubit homeCubit = HomeCubit();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  // TextEditingController timeController = TextEditingController();
  // TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String entryType = "Expense";
  String amount = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  datePicked({selectedDateNew}) {
    selectedDate = selectedDateNew;
    emit(DatePickedState());
  }

  timePicked({selectedTimeNew}) {
    selectedTime = selectedTimeNew;
    emit(TimePickedState());
  }

  // onKeyboardTap(String value) {
  //   // setState(() {
  //   amount = amount + value;
  //   emit(AmountSetState());
  //   // });
  // }
  onKeyboardTap({required String value,amountController}) {
    final int cursorPosition = amountController.selection.baseOffset;

    // Ensure cursor position is within bounds
    if (cursorPosition >= 0 && cursorPosition <= amount.length) {
      // Update the text with the new value at the cursor position
      amount = amount.substring(0, cursorPosition) +
          value +
          amount.substring(cursorPosition);

      // Update the controller with the new TextEditingValue
      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: cursorPosition + 1),
      );
    } else if (cursorPosition == -1) {
      // If cursor is at the start, append the value
      amount = value + amount;

      // Update the controller with the new TextEditingValue
      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: amount.length),
      );
    } else {
      // If cursor is at the end, append the value
      amount += value;

      // Update the controller with the new TextEditingValue
      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: amount.length),
      );
    }

    emit(AmountSetState());
  }

  rightButtonFn({amountController}) {
    final int cursorPosition = amountController.selection.baseOffset;
    print(cursorPosition);
    if (cursorPosition > 0) {
      amount = amount.substring(0, cursorPosition - 1) +
          amount.substring(cursorPosition);
      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: cursorPosition - 1),
      );
      emit(AmountSetState());
    }
  }

  void updateButtonState() {
    // setState(() {
    isButtonEnabled = formKey.currentState?.validate() ?? false;
    emit(ButtonEnableState());
    // });
  }

  sendEntry({date, time, amount, homeCubit}) async {
    print("date $date");
    print("time $time");
    print("entry $entryType");
    print("amount $amount");
    print("title ${titleController.text}");
    print("description ${descriptionController.text}");

    EntryModel entry = EntryModel(
        title: titleController.text,
        description: descriptionController.text,
        date: date ?? "", // Using the null-aware operator to handle null values
        time: time ?? "",
        entryType: entryType,
        amount: amount);
    await FirebaseService.addEntry(entry);
    await homeCubit.loadTotalAmounts();
    titleController.clear();
    descriptionController.clear();
    // amount = "";
    // emit(homeCubit.loadTotalAmounts());
  }
}
