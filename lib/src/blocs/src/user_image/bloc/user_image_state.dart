part of 'user_image_bloc.dart';

enum UserImageStatus { picking, success, failure }

class UserImageState extends Equatable {
  final XFile? pickedFile;
  UserImageState({
    this.pickedFile,
  });

  UserImageState copyWith({
    XFile? pickedFile,
  }) {
    return UserImageState(
      pickedFile: pickedFile ?? this.pickedFile,
    );
  }

  @override
  List<Object?> get props => [pickedFile];
}
