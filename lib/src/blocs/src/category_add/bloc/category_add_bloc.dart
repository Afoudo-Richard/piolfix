import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poilfix/poilfix.dart';

part 'category_add_event.dart';
part 'category_add_state.dart';

class CategoryAddBloc extends Bloc<CategoryAddEvent, CategoryAddState> {
  CategoryAddBloc() : super(CategoryAddState()) {
    on<CategoryAddImageSelected>(_onCategoryAddImageSelected);
    on<CategoryAddPhotoCleared>(_onCategoryAddPhotoCleared);
    on<CategoryAddNameChanged>(_onCategoryAddNameChanged);
    on<SubmitCategoryAddInputsChecked>(_onSubmitCategoryAddInputsChecked);
    on<CategoryAddSubmitted>(_onCategoryAddSubmitted);
  }

  Future<void> _onCategoryAddImageSelected(
    CategoryAddImageSelected event,
    Emitter<CategoryAddState> emit,
  ) async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile == null) throw Exception("Unable to get image");

      emit(
        state.copyWith(
          pickedPhoto: pickedFile,
          uploadPhotoStatus: UploadPhotoStatus.loading,
          formStatus: Formz.validate([
            state.categoryName,
          ]),
        ),
      );

      // try {
      //   emit(
      //     state.copyWith(
      //       uploadPhotoStatus: UploadPhotoStatus.success,
      //       uploadedPhoto: await _uploadPickedPhotos() ?? '',
      //     ),
      //   );
      // } catch (e) {}
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } catch (_) {
      print("No file picked");
    }
  }

  Future<void> _onCategoryAddNameChanged(
    CategoryAddNameChanged event,
    Emitter<CategoryAddState> emit,
  ) async {
    final categoryName = CategoryName.dirty(event.value);

    emit(
      state.copyWith(
        categoryName: categoryName,
        formStatus: Formz.validate([
          categoryName,
        ]),
      ),
    );
  }

  Future<void> _onCategoryAddPhotoCleared(
    CategoryAddPhotoCleared event,
    Emitter<CategoryAddState> emit,
  ) async {
    emit(
      state.copyWith(
        pickedPhoto: null,
      ),
    );
  }

  Future<void> _onSubmitCategoryAddInputsChecked(
    SubmitCategoryAddInputsChecked event,
    Emitter<CategoryAddState> emit,
  ) async {
    emit(
      state.copyWith(
        categoryName: CategoryName.dirty(state.categoryName.value),
      ),
    );
  }

  Future<void> _onCategoryAddSubmitted(
    CategoryAddSubmitted event,
    Emitter<CategoryAddState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
      ));
      try {
        var category = Category()
          ..name = state.categoryName.value
          ..description = 'A dummy description'
          ..imageThumbnail = ParseFile(File(state.pickedPhoto!.path));

        var response = await category.create();

        if (response.success) {
          print("Success");
        } else {
          print("An error occured here : ${response.toString()}");
          //throw ErrorAddingVehicle(message: response.error?.message);
        }

        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
        emit(CategoryAddState());
      } on ErrorAddingCategory catch (e) {
        emit(state.copyWith(
          errorMessage: e.getErrorsAsString ?? e.message,
          formStatus: FormzStatus.submissionFailure,
        ));
      } catch (_) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  Future<String?> _uploadPickedPhotos() async {
    try {
      ParseFileBase? parseFile = ParseFile(File(state.pickedPhoto!.path));
      await parseFile.save();

      return parseFile.url;
    } catch (e) {
      throw "Unable to upload file";
    }
  }
}
