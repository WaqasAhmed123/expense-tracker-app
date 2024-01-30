import 'package:blocship/states/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/firebase_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  void loadTotalAmounts() async {
    try {
      Map<String, dynamic> totals = await FirebaseService.getTransactionData();
      print(totals);
      emit(HomeLoadedState(totals));
      // emit(TransactionDataState(totals));
    } catch (e) {
      emit(HomeErrorState("Error loading data: $e"));
    }
  }

  void transactionData() {}
}
