
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennisapp/di/locator.dart';
import 'package:tennisapp/models/model.dart';
import 'package:tennisapp/modules/play/bloc/timechecker/time_checker_event.dart';
import 'package:tennisapp/modules/play/bloc/timechecker/time_checker_state.dart';
import 'package:tennisapp/services/service.dart';

class SelectTimeCheckerBloc extends Bloc<SelectTimeCheckerEvent, SelectTimeCheckerState>{
  SelectTimeCheckerBloc() : super(SelectTimeCheckerInitialState()){
    on<SelectTimeCheckerChangeTimeEvent>(_onChangeTimeEvent);

  }

  Future<void> _onChangeTimeEvent (SelectTimeCheckerChangeTimeEvent event, Emitter<SelectTimeCheckerState> emit) async {


    emit(SelectTimeCheckerLoadingState());
    try{
      // final response = await getIt<PolicyManager>().
      //   CheckIsFreeTime(CheckIsFreeTimeRequest(
      //     DateTime(event.selectedDate.year, event.selectedDate.month, event.selectedDate.day, event.selectedTimeStart.hour, event.selectedTimeStart.minute),
      //     DateTime(event.selectedDate.year, event.selectedDate.month, event.selectedDate.day, event.selectedTimeEnd.hour, event.selectedTimeEnd.minute),
      //     event.courtId
      //   )
      // );
      //emit(SelectTimeCheckerCheckedState(response, event.selectedDate, event.selectedTimeStart, event.selectedTimeEnd));
    } catch (e){
      emit(SelectTimeCheckerCheckedState(false, event.selectedDate, event.selectedTimeStart, event.selectedTimeEnd));
    }
  }
}