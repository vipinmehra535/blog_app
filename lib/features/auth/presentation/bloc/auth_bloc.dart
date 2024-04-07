import 'dart:async';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userLogin = userLogin,
        _userSignUp = userSignUp,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_authSignUp);
    on<AuthLogin>(_authLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  FutureOr<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSucess(user, emit),
    );
  }

  FutureOr<void> _authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final result = await _userSignUp(UserSignParam(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSucess(user, emit),
    );
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final result = await _userLogin(LoginUserParamas(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSucess(user, emit),
    );
  }

  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
