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
      child: BlocBuilder<UserImageBloc, UserImageState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, authState) {
                  return BlocBuilder<UserBloc, UserState>(
                    builder: (context, userState) {
                      return CustomContainer(
                        padding: EdgeInsets.zero,
                        height: squareSize ?? 50.sp,
                        width: squareSize ?? 50.sp,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: primaryColor,
                              color: secondaryColor,
                            ),
                          ),
                          imageUrl: authState.authenticated
                              ? userState.user?.profileImageUrl != null
                                  ? userState.user!.profileImageUrl!
                                  : "https://ui-avatars.com/api/?name=${userState.user!.firstname}+${userState.user!.lastname}"
                              : "https://ui-avatars.com/api/?name=Anonymous+A",
                        ),
                      );
                    },
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
              state.userImageStatus == UserImageStatus.uploading
                  ? Positioned(
                      bottom: 0,
                      left: 5,
                      child: LoadingIndicator(
                        radius: 10,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
