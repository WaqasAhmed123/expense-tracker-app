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
    amount = amount.substring(0, cursorPosition) +
        value +
        amount.substring(cursorPosition);
    amountController.value = amountController.value.copyWith(
      text: amount,
      selection: TextSelection.collapsed(offset: cursorPosition + 1),
    );
    emit(AmountSetState());
  }
  
  rightButtonFn() {
    final int cursorPosition = amountController.selection.baseOffset;
    if (cursorPosition > 0) {
      amount = amount.substring(0, cursorPosition - 1) +
          amount.substring(cursorPosition);
      amountController.value = amountController.value.copyWith(
        text: amount,
        selection: TextSelection.collapsed(offset: cursorPosition - 1),
      );
      emit(AmountSetState());
    }
  }
}
