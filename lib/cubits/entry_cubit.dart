import 'package:blocship/states/entry_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryInitialState());
    DateTime selectedDate = DateTime.now();

}
