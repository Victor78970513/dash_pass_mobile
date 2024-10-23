part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  final UserModel user;

  ProfileSuccessState(this.user);
}

final class ProfileErrorState extends ProfileState {}
