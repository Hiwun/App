

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_events.dart';
import 'package:tennisapp/modules/booking/bloc/booking_list_state.dart';
import 'package:tennisapp/modules/booking/booking.dart';
import 'package:tennisapp/services/service.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState>{

  BookingListBloc() : super(BookingListState()){
    on<OnBookingListInitialEvent>(_onBookingListInitial);
    on<OnBookingListRefreshListEvent>(_onBookingListRefresh);
    on<OnBookingListLoadMoreEvent>(_onBookingListLoadMore);
    on<OnBookingListRequestCancelEvent>(_onRequestCancelBooking);
  }

  Future<void> _onBookingListInitial(OnBookingListInitialEvent event, Emitter<BookingListState> emit) async{
  // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: BookingListStatus.loading));

    try {
      final response = await getIt<BookingService>().getUserBookings(state.offset, state.limit);
      emit(state.copyWith(
        status: BookingListStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: BookingListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onBookingListRefresh(OnBookingListRefreshListEvent event, Emitter<BookingListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<BookingService>().getUserBookings(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: BookingListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onBookingListLoadMore(OnBookingListLoadMoreEvent event, Emitter<BookingListState> emit) async{
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<BookingService>().getUserBookings(state.offset, state.limit);
      emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...response.data],
          status: BookingListStatus.success,  // можно оставить
          hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }


  Future<void> _onRequestCancelBooking(OnBookingListRequestCancelEvent event, Emitter<BookingListState> emit) async {
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final service = getIt<BookingService>();
      await service.requestCancelBooking(event.guid);
      final response = await service.getUserBookings(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: BookingListStatus.success, // подтверждаем, что есть свежие данные
      ));

      if(getIt.isRegistered<NextEventBloc>()){
        final bloc = getIt<NextEventBloc>();
        bloc.add(NextEventOnInitializedEvent());
      }

    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }

}