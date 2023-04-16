import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'user_image_event.dart';
part 'user_image_state.dart';

class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {
  final UserBloc userBloc;
  UserImageBloc({
    required this.userBloc,
  }) : super(UserImageState()) {
    on<SelectImage>(_onSelectImage);
  }

  void _onSelectImage(
    SelectImage event,
    Emitter<UserImageState> emit,
  ) async {
    try {
      emit(state.copyWith(
        userImageStatus: UserImageStatus.picking,
      ));
      var pickedFile = (await ImagePicker().pickImage(
        source: event.imageSource,
      ));

      if (pickedFile == null)
        throw Exception(
          "Unable to get image",
        );

      emit(
        state.copyWith(
          pickedFile: pickedFile,
          userImageStatus: UserImageStatus.uploading,
        ),
      );

      try {
        User currentUser = await ParseUser.currentUser();
        final user = await _updateProfile(currentUser);
        print("User here ------------------------------");
        print(user);
        userBloc.add(
          UserChanged(
            user: user,
          ),
        );
        emit(
          state.copyWith(
            userImageStatus: UserImageStatus.success,
          ),
        );
      } on ErrorUpdatingUserProfileImage catch (e) {
        emit(
          state.copyWith(
            userImageStatus: UserImageStatus.failure,
            errorMessage: e.message,
          ),
        );
      } catch (e) {
        emit(state.copyWith(
          userImageStatus: UserImageStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } finally {
      print("Unable to open images");
    }
  }

  Future<User> _updateProfile(User updateUser) async {
    ParseFileBase? parseFile = ParseFile(File(state.pickedFile!.path));
    await parseFile.save();

    var user = updateUser..profileImage = parseFile;

    var response = await user.save();

    if (response.success) {
      return user;
    } else {
      throw ErrorUpdatingUserProfile(message: response.error?.message);
    }
  }
}
