

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_hall_list_state.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

class VenueHallListBloc extends Bloc<VenueHallListEvent, VenueHallListState>{

  VenueHallListBloc(UuidValue venueGUID) : super(VenueHallListState(venueGUID: venueGUID)){
    on<OnVenueHallListInitialEvent>(_onVenueHallListInitial);
    on<OnVenueHallListRefreshEvent>(_onVenueHallListRefresh);
  }

  Future<void> _onVenueHallListInitial(OnVenueHallListInitialEvent event, Emitter<VenueHallListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: VenueHallListStatus.loading, venueGUID: event.venueGUID));

    try {
      final response = await getIt<VenueService>().getPublicVenueHallMaps(event.venueGUID);
      emit(state.copyWith(
        status: VenueHallListStatus.success,
        items: response.data,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: VenueHallListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onVenueHallListRefresh(OnVenueHallListRefreshEvent event, Emitter<VenueHallListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, venueGUID: event.venueGUID));

    try {
      final response = await getIt<VenueService>().getPublicVenueHallMaps(event.venueGUID);
      emit(state.copyWith(
        isLoading: false,
        items: response.data,
        status: VenueHallListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}