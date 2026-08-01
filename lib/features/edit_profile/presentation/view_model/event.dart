import 'dart:io';

sealed class EditProfileEvents {}

class GetProfileEvent extends EditProfileEvents {}

class EditProfileEvent extends EditProfileEvents {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? activityLevel;
  final String? goal;

  EditProfileEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
  });
}

class UploadPhotoEvent extends EditProfileEvents {
  final File photo;

  UploadPhotoEvent(this.photo);
}
