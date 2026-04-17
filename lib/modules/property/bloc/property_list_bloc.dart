

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/services/service.dart';

import 'property_list_events.dart';
import 'property_list_state.dart';

class PropertyListBloc extends Bloc<PropertyListEvent, PropertyListState>{

  PropertyListBloc() : super(PropertyListState()){
    on<OnPropertyListInitialEvent>(_onPropertyListInitial);
    on<OnPropertyListRefreshListEvent>(_onPropertyListRefresh);
    on<OnPropertyListLoadMoreEvent>(_onPropertyListLoadMore);
    on<OnPropertyListUpdateOneElementEvent>(_onPropertyListUpdateOneElement);
    on<OnPropertyListUpdateOneElementRemoveEvent>(_onPropertyListUpdateOneElementRemoveEvent);
  }

  Future<void> _onPropertyListInitial(OnPropertyListInitialEvent event, Emitter<PropertyListState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: PropertyListStatus.loading));

    try {
      final response = await getIt<PropertyService>().getPropertyList(state.offset, state.limit);
      emit(state.copyWith(
        status: PropertyListStatus.success,
        items: response.data,
        hasMore: state.offset + state.limit < response.pagination.total,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: PropertyListStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onPropertyListUpdateOneElement(OnPropertyListUpdateOneElementEvent event, Emitter<PropertyListState> emit) async{
    if(!state.items.any((item) => item.guid == event.newProperty.guid)){
      emit(state.copyWith(items: [event.newProperty, ...state.items]));
      return;
    }

    emit(state.copyWith(items: state.items.map((item) {
      if (event.newProperty.guid == item.guid){
        return event.newProperty;
      } else {
        return item;
      }
    }).toList()));
  }
  Future<void> _onPropertyListUpdateOneElementRemoveEvent(OnPropertyListUpdateOneElementRemoveEvent event, Emitter<PropertyListState> emit) async{
    emit(state.copyWith(items: state.items.where((item) => item.guid.uuid != event.guid.uuid).toList()));
  }
  Future<void> _onPropertyListRefresh(OnPropertyListRefreshListEvent event, Emitter<PropertyListState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true, offset: 0, limit: 20));

    try {
      final response = await getIt<PropertyService>().getPropertyList(state.offset, state.limit);
      emit(state.copyWith(
        isLoading: false,
        hasMore: state.offset + state.limit < response.pagination.total,
        items: response.data,
        status: PropertyListStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
  Future<void> _onPropertyListLoadMore(OnPropertyListLoadMoreEvent event, Emitter<PropertyListState> emit) async{
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true, offset: state.offset + state.limit));
    try {
      //final next = await repo.fetch(page: state.page + 1);
      final response = await getIt<PropertyService>().getPropertyList(state.offset, state.limit);
      emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...response.data],
          status: PropertyListStatus.success,  // можно оставить
          hasMore: state.offset + state.limit < response.pagination.total
      ));
    } catch (err) {
      emit(state.copyWith(isLoadingMore: false, offset: state.offset - state.limit /*, maybe set a loadMoreError */));
    }
  }

}