

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_tables_availability_list_state.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

class VenueTablesAvailabilityListBloc extends Bloc<VenueTablesAvailabilityListEvent, VenueTablesAvailabilityListState>{

  VenueTablesAvailabilityListBloc({required UuidValue venueGUID, DateTime? requestTime}) : super(VenueTablesAvailabilityListState(venueGUID: venueGUID, requestTime: requestTime)){
    on<OnVenueTablesAvailabilityListInitialEvent>(_onVenueTablesAvailabilityListInitial);
    on<OnVenueTablesAvailabilityListRefreshEvent>(_onVenueTablesAvailabilityListRefresh);
  }

  Future<void> _onVenueTablesAvailabilityListInitial(OnVenueTablesAvailabilityListInitialEvent event, Emitter<VenueTablesAvailabilityListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: VenueTablesAvailabilityListStatus.loading, venueGUID: event.venueGUID, requestTime: event.requestTime));

    try {
      final response = await getIt<VenueService>().getPublicAvailabilityTables(guid: event.venueGUID, requestTime: event.requestTime);
      emit(state.copyWith(
        status: VenueTablesAvailabilityListStatus.success,
        items: response.data,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: VenueTablesAvailabilityListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onVenueTablesAvailabilityListRefresh(OnVenueTablesAvailabilityListRefreshEvent event, Emitter<VenueTablesAvailabilityListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, venueGUID: event.venueGUID, requestTime: event.requestTime));


    try {
      final response = await getIt<VenueService>().getPublicAvailabilityTables(guid: event.venueGUID, requestTime: event.requestTime);
      emit(state.copyWith(
        isLoading: false,
        items: response.data,
        status: VenueTablesAvailabilityListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}