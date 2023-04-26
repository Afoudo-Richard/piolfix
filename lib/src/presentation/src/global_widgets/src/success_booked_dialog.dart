import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poilfix/poilfix.dart';

class SuccessBookedDialog extends StatelessWidget {
  const SuccessBookedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: BlocBuilder<SelectTaskBloc, SelectTaskState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.sp,
                ),
                child: Column(
                  children: [
                    3.h.ph,
                    CustomContainer(
                      padding: EdgeInsets.zero,
                      boxShadow: [],
                      height: 80.sp,
                      width: 90.sp,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primaryColor,
                            color: secondaryColor,
                          ),
                        ),
                        imageUrl: state.tasker!.profileImageUrl != null
                            ? state.tasker!.profileImageUrl!
                            : "https://ui-avatars.com/api/?name=${state.tasker!.firstname}+${state.tasker!.lastname}",
                      ),
                    ),
                    2.h.ph,
                    Text(
                      "${trans(context)!.you_have_booked} ${state.tasker!.firstname} ${state.tasker!.lastname}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                    2.h.ph,
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: () {
                          Navigator.push(
                              context, SelectPaymentMethodPage.route());
                        },
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
