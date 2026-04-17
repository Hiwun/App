import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/booking/bloc/next_event_events.dart';
import 'package:tennisapp/modules/booking/bloc/next_event_state.dart';
import 'package:tennisapp/modules/booking/components/next_event_card_empty.dart';
import 'package:tennisapp/services/booking/booking_service.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

class NextEventBloc extends Bloc<NextEventEvents, NextEventState>{
  NextEventBloc() : super(NextEventState()){
    on<NextEventOnInitializedEvent>(_onInitializedModule);
    on<OnNextEventRequestCancelEvent>(_onRequestCancelBooking);
  }

  Future<void> _onInitializedModule(NextEventOnInitializedEvent event, Emitter<NextEventState> emit) async {
    try{

      emit(state.copyWith(
          isLoading: true,
          status: NextEventStatus.loading,
          nextEvent: null)
      );

      final response = await getIt<BookingService>().getNextEventUser();

      emit(state.copyWith(
          nextEvent: response.data,
          status: NextEventStatus.success,
          isLoading: false)
      );

    } catch (e){
      emit(state.copyWith(
          status: NextEventStatus.failure,
          isLoading: false,
          nextEvent: null,
          errorMessage: e.toString()
      ));
    }
  }
  Future<void> _onRequestCancelBooking(OnNextEventRequestCancelEvent event, Emitter<NextEventState> emit) async {
    try{

      emit(state.copyWith(
          isLoading: true,
          status: NextEventStatus.loading,
          nextEvent: null)
      );

      final service = getIt<BookingService>();
      await service.requestCancelBooking(event.guid);
      final response = await service.getNextEventUser();

      emit(state.copyWith(
          nextEvent: response.data,
          status: NextEventStatus.success,
          isLoading: false)
      );

    } catch (e){
      emit(state.copyWith(
          status: NextEventStatus.failure,
          isLoading: false,
          nextEvent: null,
          errorMessage: e.toString()
      ));
    }
  }
}