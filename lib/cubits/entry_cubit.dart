import 'package:blocship/states/entry_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EntryCubit extends Cubit<EntryState> {
//  EntryCubit= BlocProvider.of(context)
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController? dateController;
  TextEditingController? timeController;
  TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  EntryCubit() : super(EntryInitialState()) {
    // dateController = TextEditingController(
    //   text: DateFormat('dd MMM yyyy').format(selectedDate),
    // );
    timeController = TextEditingController(
      text: DateFormat('h:mm a')
          .format(DateTime(2022, 1, 1, selectedTime.hour, selectedTime.minute)),
    );
  }
  datePicked({selectedDateNew}) {
    selectedDate = selectedDateNew;
    emit(DatePickedState());
  }

  timePicked({selectedTimeNew}) {
    selectedTime = selectedTimeNew;
    emit(TimePickedState());
  }
}
