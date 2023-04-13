import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CategoryAddPage extends StatelessWidget {
  const CategoryAddPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CategoryAddPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryAddBloc, CategoryAddState>(
      listener: (context, state) {
        // if (state.formStatus.isSubmissionSuccess) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(
        //         backgroundColor: Colors.green,
        //         content: Text("Category Added Successfully"),
        //       ),
        //     );
        // } else if (state.formStatus.isSubmissionFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       SnackBar(
        //         content: Text(state.errorMessage ?? 'Failed to '),
        //       ),
        //     );
        // }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Add Category',
        ),
        body: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.h.ph,
              BlocBuilder<CategoryAddBloc, CategoryAddState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Image',
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                      2.h.ph,
                      Row(children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<CategoryAddBloc>(context)
                                .add(CategoryAddImageSelected());
                          },
                          child: Column(
                            children: [
                              CustomCircle(
                                radius: 45.sp,
                                child: Icon(
                                  Icons.add,
                                  size: 20.sp,
                                  color: Colors.white,
                                ),
                              ),
                              // 1.h.ph,
                              // Text(
                              //   "Add photo",
                              //   style: TextStyle(
                              //     fontSize: 9.sp,
                              //     color: primaryColor,
                              //   ),
                              // ),
                              state.pickedPhoto != null
                                  ? Column(
                                      children: [
                                        2.h.ph,
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<CategoryAddBloc>(
                                                    context)
                                                .add(CategoryAddPhotoCleared());
                                          },
                                          child: Text(
                                            "Clear photo",
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        4.w.pw,
                        state.pickedPhoto != null
                            ? CustomContainer(
                                width: 100.sp,
                                height: 100.sp,
                                padding: EdgeInsets.zero,
                                child: Image(
                                  image: FileImage(
                                    File(state.pickedPhoto!.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ]),
                    ],
                  );
                },
              ),
              2.h.ph,
              BlocBuilder<CategoryAddBloc, CategoryAddState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      1.h.ph,
                      CustomInput(
                        label: 'Category Name',
                        inputHintText: trans(context)!.enter_vehicle_price,
                        backgroundColor: Colors.white.withOpacity(0.7),
                        labelTextStyle: const TextStyle(
                          color: primaryColor,
                        ),
                        inputErrorText: state.categoryName.invalid
                            ? state.categoryName.error
                            : null,
                        onChanged: (value) {
                          BlocProvider.of<CategoryAddBloc>(context)
                              .add(CategoryAddNameChanged(value));
                        },
                      ),
                    ],
                  );
                },
              ),
              4.h.ph,
              SizedBox(
                width: 100.w,
                child: BlocBuilder<CategoryAddBloc, CategoryAddState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        state.formStatus.isValidated
                            ? context
                                .read<CategoryAddBloc>()
                                .add(CategoryAddSubmitted())
                            : BlocProvider.of<CategoryAddBloc>(context)
                                .add(SubmitCategoryAddInputsChecked());
                      },
                      child: state.formStatus.isSubmissionInProgress
                          ? LoadingIndicator(
                              color: secondaryColor,
                            )
                          : Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                letterSpacing: 1.5,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
