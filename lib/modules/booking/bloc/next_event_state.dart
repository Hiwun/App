import 'package:tennisapp/models/model.dart';

enum NextEventStatus { initial, loading, success, failure}

class NextEventState {
  final NextEventStatus status;
  final NextEvent? nextEvent;
  final String? errorMessage;
  final bool isLoading;

  NextEventState({
    this.status = NextEventStatus.initial,
    this.nextEvent,
    this.errorMessage,
    this.isLoading = false
  });

  NextEventState copyWith({
    NextEventStatus? status,
    NextEvent? nextEvent,
    String? errorMessage,
    bool? isLoading
  }) {
    return NextEventState(
      status: status ?? this.status,
      nextEvent: nextEvent,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading
    );
  }

}
