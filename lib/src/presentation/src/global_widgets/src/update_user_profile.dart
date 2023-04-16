import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({
    super.key,
    this.color = Colors.orangeAccent,
    this.message,
  });

  final Color color;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return userState.user?.tools == null ||
                userState.user!.tools!.isEmpty ||
                userState.user?.skills == null ||
                userState.user!.skills!.isEmpty ||
                userState.user?.pricePerHr == null ||
                userState.user!.pricePerHr!.isEmpty
            ? Column(
                children: [
                  2.h.ph,
                  Stack(
                    children: [
                      Column(
                        children: [
                          10.sp.ph,
                          CustomContainer(
                            border: Border.all(
                              color: color,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    message ??
                                        "Almost there. Complete your profile, get approval and start earning",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),
                                4.w.pw,
                                CustomButton(
                                  backgroundColor: color,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      TaskerProfileInfoPage.route(),
                                    );
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: CustomCircle(
                          radius: 20.sp,
                          padding: EdgeInsets.all(1.sp),
                          color: primaryColor,
                          child: Icon(
                            LineIcons.times,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  2.h.ph,
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
