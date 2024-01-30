import 'package:blocship/models/entries_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final Map<String, dynamic> totals;

  HomeLoadedState(this.totals);
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

// class TransactionDataState extends HomeState {
//   // final String errorMessage;
//   List<EntryModel> transactionData;

//   TransactionDataState(this.transactionData);
// }
