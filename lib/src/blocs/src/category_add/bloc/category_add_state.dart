// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'category_add_bloc.dart';

enum UploadPhotoStatus { initial, loading, failed, success }

class CategoryAddState extends Equatable {
  final XFile? pickedPhoto;
  final CategoryName categoryName;
  final String uploadedPhoto;
  final FormzStatus formStatus;
  final String? errorMessage;
  final UploadPhotoStatus uploadPhotoStatus;

  CategoryAddState({
    this.categoryName = const CategoryName.pure(),
    this.pickedPhoto,
    this.uploadedPhoto = '',
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
    this.uploadPhotoStatus = UploadPhotoStatus.initial,
  });

  @override
  List<Object?> get props {
    return [
      pickedPhoto,
      categoryName,
      uploadedPhoto,
      formStatus,
      errorMessage,
      uploadPhotoStatus,
    ];
  }

  CategoryAddState copyWith({
    XFile? pickedPhoto,
    CategoryName? categoryName,
    String? uploadedPhoto,
    FormzStatus? formStatus,
    String? errorMessage,
    UploadPhotoStatus? uploadPhotoStatus,
  }) {
    return CategoryAddState(
      pickedPhoto: pickedPhoto ?? this.pickedPhoto,
      categoryName: categoryName ?? this.categoryName,
      uploadedPhoto: uploadedPhoto ?? this.uploadedPhoto,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      uploadPhotoStatus: uploadPhotoStatus ?? this.uploadPhotoStatus,
    );
  }
}
