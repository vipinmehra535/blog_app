part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoadedIn extends AppUserState {
  final User user;
  AppUserLoadedIn(this.user);
}
