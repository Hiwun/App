

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_list_events.dart';
import 'package:tennisapp/modules/venues/bloc/venue/venue_list_state.dart';
import 'package:tennisapp/services/service.dart';

class VenueListBloc extends Bloc<VenueListEvent, VenueListState>{

  VenueListBloc() : super(VenueListState()){
    on<OnVenueListInitialEvent>(_onVenueListInitial);
    on<OnVenueListRefreshListEvent>(_onVenueListRefresh);
    on<OnVenueListLoadMoreEvent>(_onVenueListLoadMore);
  }

  Future<void> _onVenueListInitial(OnVenueListInitialEvent event, Emitter<VenueListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: VenueListStatus.loading));

    try {
      final response = await getIt<VenueService>().getVenueList(state.offset, state.limit);
      emit(state.copyWith(
        status: VenueListStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: VenueListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onVenueListRefresh(OnVenueListRefreshListEvent event, Emitter<VenueListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<VenueService>().getVenueList(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: VenueListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onVenueListLoadMore(OnVenueListLoadMoreEvent event, Emitter<VenueListState> emit) async{
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<VenueService>().getVenueList(state.offset, state.limit);
      emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...response.data],
          status: VenueListStatus.success,  // можно оставить
          hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }

}