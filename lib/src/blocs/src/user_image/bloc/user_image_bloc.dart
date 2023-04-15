import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'user_image_event.dart';
part 'user_image_state.dart';

class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {
  UserImageBloc() : super(UserImageState()) {
    on<SelectImage>(_onSelectImage);
  }

  void _onSelectImage(
    SelectImage event,
    Emitter<UserImageState> emit,
  ) async {
    try {
      var pickedFile =
          (await ImagePicker().pickImage(source: event.imageSource));

      if (pickedFile == null) throw Exception("Unable to get image");
      emit(state.copyWith(pickedFile: pickedFile));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } finally {
      print("Unable to open images");
    }
  }

  void selectImage(ImageSource imgsource) async {
    try {
      var pickedFile = (await ImagePicker().pickImage(source: imgsource))!;
      emit(state.copyWith(pickedFile: pickedFile));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } finally {
      print("Unable to open images");
    }
  }
}
