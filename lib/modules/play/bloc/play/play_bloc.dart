

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/modules/play/bloc/play/play_event.dart';
import 'package:tennisapp/modules/play/bloc/play/play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState>{
  PlayBloc() : super(PlayInitialState()){
    on<PlaySelectTypeEvent>(_onSelectPlayType);
    on<PlaySelectCourtEvent>(_onSelectPlayCourt);
    on<PlaySelectTimeEvent>(_onSelectPlayTime);
    on<PlaySelectTrainerEvent>(_onSelectPlayTrainer);
    on<PlaySelectBookingInformationEvent>(_onSelectPlayBookingInformation);
  }

  Future<void> _onSelectPlayType(PlaySelectTypeEvent event, Emitter<PlayState> emit) async {
    emit(PlaySelectTypeState(event.type));
  }
  Future<void> _onSelectPlayCourt(PlaySelectCourtEvent event, Emitter<PlayState> emit) async {
    final currentState = state;
    if(currentState is PlaySelectTypeState){
      bool allowSelectedFreeTime = false;
      //emit(PlaySelectCourtState(currentState.type, event.court, allowSelectedFreeTime));
    } else if (currentState is PlaySelectTimeState){
      //emit(PlaySelectCourtAfterTimeState(currentState.type, event.court, currentState.selectedDate, currentState.selectedTimeStart, currentState.selectedTimeEnd));
    }
  }
  Future<void> _onSelectPlayTime(PlaySelectTimeEvent event, Emitter<PlayState> emit) async {
    final currentState = state;
    if(currentState is PlaySelectTypeState){
      emit(PlaySelectTimeState(currentState.type, event.selectedDate, event.selectedTimeStart, event.selectedTimeEnd));
    }
  }
  Future<void> _onSelectPlayTrainer(PlaySelectTrainerEvent event, Emitter<PlayState> emit) async {
    final currentState = state;
    if(currentState is PlaySelectCourtAfterTimeState){
      emit(PlaySelectTrainerState(
          currentState.type,
          currentState.selectedDate,
          currentState.selectedTimeStart,
          currentState.selectedTimeEnd,
          event.requireTrainer,
          //currentState.court
      ));
    }
  }
  Future<void> _onSelectPlayBookingInformation(PlaySelectBookingInformationEvent event, Emitter<PlayState> emit) async {
    final currentState = state;
    if(currentState is PlaySelectCourtState){
      // emit(PlaySelectBookingInformationState(
      //   currentState.type,
      //   event.selectedDate,
      //   event.selectedTimeStart,
      //   event.selectedTimeEnd,
      //   event.requireTrainer
      //   currentState.court,
      //   currentState.allowSelectedFreeTime
      // ));
    }
  }
}