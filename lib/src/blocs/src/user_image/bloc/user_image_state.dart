// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_image_bloc.dart';

enum UserImageStatus { initial, picking, uploading, success, failure }

class UserImageState extends Equatable {
  final XFile? pickedFile;
  final UserImageStatus userImageStatus;
  final String? errorMessage;

  UserImageState({
    this.pickedFile,
    this.userImageStatus = UserImageStatus.initial,
    this.errorMessage,
  });

  UserImageState copyWith({
    XFile? pickedFile,
    UserImageStatus? userImageStatus,
    String? errorMessage,
  }) {
    return UserImageState(
      pickedFile: pickedFile ?? this.pickedFile,
      userImageStatus: userImageStatus ?? this.userImageStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        pickedFile,
        userImageStatus,
        errorMessage,
      ];
}
