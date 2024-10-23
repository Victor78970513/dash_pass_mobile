import 'dart:async';

import 'package:dash_pass/models/user_model.dart';
import 'package:dash_pass/repositories/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserModel? userModel;
  final UserRepository _userRepository;
  ProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(ProfileInitial()) {
    on<OnGetProfileEvent>(_onGetProfileEvent);
    on<OnEditProfileEvent>(_onEditProfileEvent);
  }

  FutureOr<void> _onGetProfileEvent(
      OnGetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(milliseconds: 2000));
    final user = await _userRepository.getUserData(event.userID);
    if (user != null) {
      userModel = user;
      emit(ProfileSuccessState(user));
    } else {
      emit(ProfileErrorState());
    }
  }

  FutureOr<void> _onEditProfileEvent(
      OnEditProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    if (event.localImage != null) {
      final image = await _userRepository.updateProfileImage(event.localImage!);
      final response = await _userRepository.updateUserData(
        uid: event.uid,
        username: event.username,
        profilePictureUrl: image,
      );
      if (response) {
        add(OnGetProfileEvent(event.uid));
      } else {
        emit(ProfileErrorState());
      }
    } else {
      final response = await _userRepository.updateUserData(
        uid: event.uid,
        username: event.username,
        profilePictureUrl: event.profilePictureUrl,
      );
      if (response) {
        add(OnGetProfileEvent(event.uid));
      } else {
        emit(ProfileErrorState());
      }
    }
  }
}
