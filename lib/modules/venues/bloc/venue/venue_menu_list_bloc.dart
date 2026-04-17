

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_menu_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_menu_list_state.dart';
import 'package:tennisapp/services/service.dart';
import 'package:uuid/uuid.dart';

class VenueMenuListBloc extends Bloc<VenueMenuListEvent, VenueMenuListState>{

  VenueMenuListBloc({required UuidValue venueGUID, DateTime? requestTime}) : super(VenueMenuListState(venueGUID: venueGUID, requestTime: requestTime)){
    on<OnVenueMenuListInitialEvent>(_onVenueMenuListInitial);
    on<OnVenueMenuListRefreshEvent>(_onVenueMenuListRefresh);
  }

  Future<void> _onVenueMenuListInitial(OnVenueMenuListInitialEvent event, Emitter<VenueMenuListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: VenueMenuListStatus.loading, venueGUID: event.venueGUID, requestTime: event.requestTime));

    try {
      final response = await getIt<VenueService>().getPublicVenueMenu(guid: event.venueGUID, requestTime: event.requestTime);
      emit(state.copyWith(
        status: VenueMenuListStatus.success,
        items: response.data,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: VenueMenuListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onVenueMenuListRefresh(OnVenueMenuListRefreshEvent event, Emitter<VenueMenuListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, venueGUID: event.venueGUID, requestTime: event.requestTime));

    try {
      final response = await getIt<VenueService>().getPublicVenueMenu(guid: event.venueGUID, requestTime: event.requestTime);
      emit(state.copyWith(
        isLoading: false,
        items: response.data,
        status: VenueMenuListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}