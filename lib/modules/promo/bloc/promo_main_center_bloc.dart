

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_center_events.dart';
import 'package:tennisapp/modules/promo/bloc/promo_main_center_state.dart';
import 'package:tennisapp/services/service.dart';

class PromoMainCenterBloc extends Bloc<PromoMainCenterEvent, PromoMainCenterState>{

  PromoMainCenterBloc() : super(PromoMainCenterState()){
    on<OnPromoMainCenterInitialEvent>(_onPromoMainCenterInitial);
    on<OnPromoMainCenterRefreshListEvent>(_onPromoMainCenterRefresh);
  }

  Future<void> _onPromoMainCenterInitial(OnPromoMainCenterInitialEvent event, Emitter<PromoMainCenterState> emit) async{
    // Явно очищаем предыдущую ошибку загрузки и ставим loading
    emit(state.copyWith(status: PromoMainCenterStatus.loading));

    try {
      final response = await getIt<PromotionService>().getPromotionTopCenter();
      emit(state.copyWith(
        status: PromoMainCenterStatus.success,
        items: response.data,
        // loadError: null // уже null, можно не повторять
      ));
    } catch (err) {
      emit(state.copyWith(status: PromoMainCenterStatus.failure, errorMessage: 'Ошибка загрузки'));
    }
  }
  Future<void> _onPromoMainCenterRefresh(OnPromoMainCenterRefreshListEvent event, Emitter<PromoMainCenterState> emit) async{
    if (state.isLoading) return;
    // показываем refresh-индикатор, сбрасываем refreshError
    emit(state.copyWith(isLoading: true));

    try {
      final response = await getIt<PromotionService>().getPromotionTopCenter();
      emit(state.copyWith(
        isLoading: false,
        items: response.data,
        status: PromoMainCenterStatus.success, // подтверждаем, что есть свежие данные
      ));
    } catch (err) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Ошибка обновления'));
    }
  }
}