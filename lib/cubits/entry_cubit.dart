import 'package:blocship/services/firebase_service.dart';
import 'package:blocship/states/entry_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/entries_model.dart';

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryInitialState());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String entryType = "Expense";
  String amount = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

// show picked time and date on scr
  datePicked({selectedDateNew}) {
    selectedDate = selectedDateNew;
    emit(DatePickedState());
  }

  timePicked({selectedTimeNew}) {
    selectedTime = selectedTimeNew;
    emit(TimePickedState());
  }

// handle onscr keyboard cursor
  onKeyboardTap({required String value, amountController}) {
    final int cursorPosition = amountController.selection.baseOffset;

    if (cursorPosition >= 0 && cursorPosition <= amount.length) {
      amount = amount.substring(0, cursorPosition) +
          value +
          amount.substring(cursorPosition);

      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: cursorPosition + 1),
      );
    } else if (cursorPosition == -1) {
      amount = value + amount;

      amountController.value = TextEditingValue(
        text: amount,
        selection: TextSelection.collapsed(offset: amount.length),
      );
    } else {
      amount += value;

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
    isButtonEnabled = formKey.currentState?.validate() ?? false;
    emit(ButtonEnableState());
  }

// upload data
  sendEntry({date, time, amount, homeCubit}) async {
    EntryModel entry = EntryModel(
        title: titleController.text,
        description: descriptionController.text,
        date: date ?? "",
        time: time ?? "",
        entryType: entryType,
        amount: amount);
    await FirebaseService.addEntry(entry);
    await homeCubit.loadTotalAmounts();
    titleController.clear();
    descriptionController.clear();
  }
}
