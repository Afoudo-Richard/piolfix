import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class UserImage extends StatelessWidget {
  final bool isEditable;
  final double? squareSize;
  final bool showEditIcon;

  const UserImage({
    super.key,
    this.isEditable = true,
    this.showEditIcon = false,
    this.squareSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isEditable
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const SelectImageSourceDialog();
                },
              )
            : null;
      },
      child: Stack(
        children: [
          BlocBuilder<UserImageBloc, UserImageState>(
            builder: (context, state) {
              return CustomContainer(
                padding: EdgeInsets.zero,
                height: squareSize ?? 50.sp,
                width: squareSize ?? 50.sp,
                child: state.pickedFile != null
                    ? Image(
                        image: FileImage(
                          File(state.pickedFile!.path),
                        ),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primaryColor,
                            color: secondaryColor,
                          ),
                        ),
                        imageUrl: "https://ui-avatars.com/api/?name=U+Shop",
                      ),
              );
            },
          ),
          showEditIcon
              ? Positioned(
                  bottom: 0,
                  right: 5,
                  child: CustomCircle(
                    radius: 20.sp,
                    padding: EdgeInsets.all(1.sp),
                    color: primaryColor,
                    child: Icon(
                      LineIcons.pen,
                      color: Colors.white,
                      size: 15.sp,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
