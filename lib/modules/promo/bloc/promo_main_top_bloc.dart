

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_events.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_top_state.dart';
import 'package:tennisapp/services/service.dart';

class PromoMainTopBloc extends Bloc<PromoMainTopEvent, PromoMainTopState>{

  PromoMainTopBloc() : super(PromoMainTopState()){
    on<OnPromoMainTopInitialEvent>(_onPromoMainTopInitial);
    on<OnPromoMainTopRefreshListEvent>(_onPromoMainTopRefresh);
  }

  Future<void> _onPromoMainTopInitial(OnPromoMainTopInitialEvent event, Emitter<PromoMainTopState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: PromoMainTopStatus.loading));

    try {
      final response = await getIt<PromotionService>().getPromotionTop();
      emit(state.copyWith(
        status: PromoMainTopStatus.success,
        items: response.data,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: PromoMainTopStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onPromoMainTopRefresh(OnPromoMainTopRefreshListEvent event, Emitter<PromoMainTopState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true));

    try {
      final response = await getIt<PromotionService>().getPromotionTop();
      emit(state.copyWith(
        isLoading: false,
        items: response.data,
        status: PromoMainTopStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}