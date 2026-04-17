
import "package:dio/dio.dart";
import "package:tennisapp/di/locator.dart";
import "package:tennisapp/features/auth/bloc/auth_bloc_event.dart";
import "package:tennisapp/features/auth/bloc/auth_bloc_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:tennisapp/services/service.dart";
import "package:tennisapp/storage/storage.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc({required bool isLoggedIn}) : super(isLoggedIn ? AuthAuthenticatedState() : AuthInitialState()){
    on<LoginRequested>(_onLoginRequested);
    on<LoginPhoneRequested>(_onLoginPhoneRequested);
    on<CodeAuthRequestedEvent>(_onCheckCodeAuth);
    on<LogoutRequested>((event, emit) => emit(AuthInitialState()));
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try{
      final authService = getIt<AuthService>();
      await authService.login(event.username, event.password);
      await authService.currentUser();
      final user = getIt<UserStorage>().user;
      final token = getIt<TokenStorage>().token;
      if(user != null && token != null){
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthInitialState());
      }
    } on DioException catch (e){
      emit(AuthInitialState());
    } catch (e){
      emit(AuthInitialState());
    }
  }
  Future<void> _onLoginPhoneRequested(LoginPhoneRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try{
      final authService = getIt<AuthService>();
      final authResponse = await authService.loginPhone(event.phone);
      emit(AuthLoginPhoneApproveState(authResponse.userGUID));
    } on DioException catch (e){
      emit(AuthLoginFailureState());
    } catch (e){
      emit(AuthLoginFailureState());
    }
  }
  Future<void> _onCheckCodeAuth(CodeAuthRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try{
      final authService = getIt<AuthService>();
      await authService.checkCodePhone(event.userGUID, event.code);
      await authService.currentUser();
      final user = getIt<UserStorage>().user;
      final token = getIt<TokenStorage>().token;
      if(user != null && token != null){
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthInitialState());
      }
    } on DioException catch (e){
      emit(AuthCheckCodeFailureState(event.userGUID));
    } catch (e){
      emit(AuthCheckCodeFailureState(event.userGUID));
    }
  }
}