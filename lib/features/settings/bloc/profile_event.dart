part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class OnGetProfileEvent extends ProfileEvent {
  final String userID;

  OnGetProfileEvent(this.userID);
}

final class OnEditProfileEvent extends ProfileEvent {
  final String username;
  final double weight;
  final double height;
  final String physicalLimitations;
  final String foodRestrictions;
  final String profilePictureUrl;
  final XFile? localImage;
  final String goal;
  final String uid;

  OnEditProfileEvent({
    required this.username,
    required this.weight,
    required this.height,
    required this.physicalLimitations,
    required this.foodRestrictions,
    required this.profilePictureUrl,
    this.localImage,
    required this.goal,
    required this.uid,
  });
}
