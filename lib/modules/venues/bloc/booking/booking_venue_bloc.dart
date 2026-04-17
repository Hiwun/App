

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/booking/booking.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_bloc.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

import 'booking_venue_event.dart';
import 'booking_venue_state.dart';

class BookingVenueBloc extends Bloc<BookingVenueEvent, BookingVenueState>{

  Timer? _updateDebounceTimer;
  Timer? _initialDebounceTimer;

  BookingVenueBloc() : super(BookingVenueState(startTime: DateTime.now(), expectedEndTime: DateTime.now().add(Duration(hours: 1)))){
    on<OnBookingVenueInitialEvent>((event, emit){
      if(event.debounce){
        _initialDebounceTimer?.cancel();
        _initialDebounceTimer = Timer(Duration(milliseconds: event.debounceMillisecond), () {
          _onBookingVenueInitial(event, emit);
        });
      } else {
        _onBookingVenueInitial(event, emit);
      }

    });
    on<OnBookingVenueUpdateEvent>((event, emit){
      if(event.debounce){
        _updateDebounceTimer?.cancel();
        _updateDebounceTimer = Timer(Duration(milliseconds: event.debounceMillisecond), () {
          _onBookingVenueUpdate(event, emit);
        });
      } else {
        _onBookingVenueUpdate(event, emit);
      }

    });
    on<OnBookingVenueSendEvent>(_onBookingVenueSend);
  }


  Future<void> _onBookingVenueInitial(OnBookingVenueInitialEvent event, Emitter<BookingVenueState> emit) async {

    try {
      emit(state.copyWith(
        status: BookingVenueStatus.waitFill,
        venueGUID: event.venueGUID,
        userGUID: event.userGUID,
        promoGUID: event.promoGUID,
        guid: Uuid().v4obj(),
        startTime: event.startTime,
        expectedEndTime: event.expectedEndTime,
        venueName: event.venueName,
        venueShortAddress: event.venueShortAddress,
        phone: event.phone,
        guestName: event.guestName,
        guestCount: event.guestCount,
        specialRequest: event.specialRequest,
        amount: event.amount,
        tables: event.tables,
        menuItems: event.menuItems
      ));
    } catch (err) {
      emit(state.copyWith(status: BookingVenueStatus.failure, errorMessage: 'Ошибка'));
    }
  }
  Future<void> _onBookingVenueUpdate(OnBookingVenueUpdateEvent event, Emitter<BookingVenueState> emit) async{
    if (state.isLoading) return;

    try {
      emit(state.copyWith(
          status: BookingVenueStatus.waitFill,
          startTime: event.startTime,
          expectedEndTime: event.expectedEndTime,
          venueName: event.venueName,
          venueShortAddress: event.venueShortAddress,
          phone: event.phone,
          guestName: event.guestName,
          guestCount: event.guestCount,
          specialRequest: event.specialRequest,
          amount: event.amount,
          tables: event.tables,
          menuItems: event.menuItems
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onBookingVenueSend(OnBookingVenueSendEvent event, Emitter<BookingVenueState> emit) async{
    if (state.isLoading) return;

    emit(state.copyWith(status: BookingVenueStatus.loading));

    try {
      final model = Booking(
        venueGUID: state.venueGUID,
        promoGUID: state.promoGUID,
        userGUID: state.userGUID,
        startTime: state.startTime,
        expectedEndTime: state.expectedEndTime,
        status: 'pending',
        venueName: state.venueName,
        venueShortAddress: state.venueShortAddress,
        phone: state.phone,
        guestName: state.guestName,
        guestCount: state.guestCount,
        specialRequest: state.specialRequest,
        guid: state.guid,
        menuItems: state.menuItems,
        tables: state.tables,
        amount: state.amount,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      );
      await getIt<BookingService>().book(model);
      final availabilityBloc = getIt<VenueTablesAvailabilityListBloc>();
      availabilityBloc.add(OnVenueTablesAvailabilityListRefreshEvent(venueGUID: state.venueGUID, requestTime: availabilityBloc.state.requestTime));

      if(getIt.isRegistered<NextEventBloc>()){
        final bloc = getIt<NextEventBloc>();
        bloc.add(NextEventOnInitializedEvent());
      }

      emit(state.copyWith(status: BookingVenueStatus.success));
    } catch (err) {
      emit(state.copyWith(status: BookingVenueStatus.failure, isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}