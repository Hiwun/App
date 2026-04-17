

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_list_map_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_list_map_state.dart';
import 'package:tennisapp/services/service.dart';

class VenueListMapBloc extends Bloc<VenueListMapEvent, VenueListMapState>{

  VenueListMapBloc() : super(VenueListMapState()){
    on<OnVenueListMapInitialEvent>(_onVenueListMapInitial);
    on<OnVenueListMapRefreshListEvent>(_onVenueListMapRefresh);
    on<OnVenueListMapLoadMoreEvent>(_onVenueListMapLoadMore);
  }

  Future<void> _onVenueListMapInitial(OnVenueListMapInitialEvent event, Emitter<VenueListMapState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: VenueListMapStatus.loading));

    try {
      final response = await getIt<VenueService>().getVenueMapList(state.offset, state.limit);
      emit(state.copyWith(
        status: VenueListMapStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: VenueListMapStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onVenueListMapRefresh(OnVenueListMapRefreshListEvent event, Emitter<VenueListMapState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<VenueService>().getVenueMapList(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: VenueListMapStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onVenueListMapLoadMore(OnVenueListMapLoadMoreEvent event, Emitter<VenueListMapState> emit) async{
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<VenueService>().getVenueMapList(state.offset, state.limit);
      emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...response.data],
          status: VenueListMapStatus.success,  // можно оставить
          hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }

}