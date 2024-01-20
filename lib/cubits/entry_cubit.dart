import 'package:blocship/states/entry_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryInitialState());
//  EntryCubit= BlocProvider.of(context)
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController? dateController;
  TextEditingController? timeController;
  TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? transactionType;
  String amount = "";

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
  onKeyboardTap(String value) {
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


  rightButtonFn() {
    final int cursorPosition = amountController.selection.baseOffset;
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
}
