

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/notification/bloc/notificaiton_list_events.dart';
import 'package:tennisapp/modules/notification/bloc/notification_list_state.dart';
import 'package:tennisapp/services/service.dart';

class NotificationListBloc extends Bloc<NotificationListEvent, NotificationListState>{

  NotificationListBloc() : super(NotificationListState()){
    on<OnNotificationListInitialEvent>(_onNotificationListInitial);
    on<OnNotificationListRefreshListEvent>(_onNotificationListRefresh);
    on<OnNotificationListLoadMoreEvent>(_onNotificationListLoadMore);
  }

  Future<void> _onNotificationListInitial(OnNotificationListInitialEvent event, Emitter<NotificationListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: NotificationListStatus.loading));

    try {
      final response = await getIt<NotificationService>().getUserNotifications(state.offset, state.limit);
      emit(state.copyWith(
        status: NotificationListStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: NotificationListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onNotificationListRefresh(OnNotificationListRefreshListEvent event, Emitter<NotificationListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<NotificationService>().getUserNotifications(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: NotificationListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onNotificationListLoadMore(OnNotificationListLoadMoreEvent event, Emitter<NotificationListState> emit) async{
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<NotificationService>().getUserNotifications(state.offset, state.limit);
      emit(state.copyWith(
        isLoadingMore: false,
        items: [...state.items, ...response.data],
        status: NotificationListStatus.success,  // можно оставить
        hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }

}