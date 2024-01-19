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
  datePicked({selectedDateNew}) {
    selectedDate = selectedDateNew;
    emit(DatePickedState());
  }

  timePicked({selectedTimeNew}) {
    selectedTime = selectedTimeNew;
    emit(TimePickedState());
  }
}
