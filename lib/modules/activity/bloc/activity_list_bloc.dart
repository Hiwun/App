

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';
import 'package:tennisapp/utils/utils.dart';
import 'package:uuid/uuid.dart';

import 'activity_list_events.dart';
import 'activity_list_state.dart';

class ActivityListBloc extends Bloc<ActivityListEvent, ActivityListState>{

  ActivityListBloc() : super(ActivityListState.initial()){
    on<OnActivityListInitialEvent>(_onActivityListInitial);
    on<OnActivityListRefreshListEvent>(_onActivityListRefresh);
    on<OnActivityListLoadMoreEvent>(_onActivityListLoadMore);
  }

  Future<void> _onActivityListInitial(OnActivityListInitialEvent event, Emitter<ActivityListState> emit) async{
    if(state.entityGUID == Uuid().zero || state.entityType == "") return;
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: ActivityListStatus.loading));

    try {

      final response = await getIt<ActivityService>().getActivitiesList(state.offset, state.limit, state.entityType, state.entityGUID);
      emit(state.copyWith(
        status: ActivityListStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: ActivityListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onActivityListRefresh(OnActivityListRefreshListEvent event, Emitter<ActivityListState> emit) async{
    if(state.entityGUID == Uuid().zero || state.entityType == "") return;
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<ActivityService>().getActivitiesList(state.offset, state.limit, state.entityType, state.entityGUID);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: ActivityListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onActivityListLoadMore(OnActivityListLoadMoreEvent event, Emitter<ActivityListState> emit) async{
    if(state.entityGUID == Uuid().zero || state.entityType == "") return;
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<ActivityService>().getActivitiesList(state.offset, state.limit, state.entityType, state.entityGUID);
      emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...response.data],
          status: ActivityListStatus.success,  // можно оставить
          hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }

}