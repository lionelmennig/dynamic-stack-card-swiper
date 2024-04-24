import 'package:flutter_bloc/flutter_bloc.dart';

import 'example_candidate_model.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  bool isLocked;
  final ExampleCandidateModel model;

  CardBloc({this.isLocked = false, required this.model})
      : super(CardState(isLocked: isLocked, model: model)) {
    on<CardUnlockEvent>((event, emit) {
      isLocked = false;
      emit(CardState(isLocked: isLocked, model: model));
    });
  }
}

abstract class CardEvent {}

class CardUnlockEvent extends CardEvent {}

class CardState {
  final bool isLocked;
  final ExampleCandidateModel model;
  CardState({required this.isLocked, required this.model});
}
