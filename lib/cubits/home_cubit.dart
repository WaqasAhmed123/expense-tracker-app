import 'package:blocship/states/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/firebase_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void loadTotalAmounts() async {
    // try {
    //   Map<String, double> totals = await FirebaseService.getTotalAmounts();
    //   print(totals);
      // emit(HomeLoadedState(totals));
      emit(HomeLoadingState());
    // } catch (e) {
      // emit(HomeErrorState("Error loading data: $e"));
    // }
  }
}
