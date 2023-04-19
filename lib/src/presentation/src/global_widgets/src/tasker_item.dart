import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:poilfix/poilfix.dart';

class TaskerItem extends StatelessWidget {
  final User user;

  const TaskerItem({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, TaskerProfilePage.route(user));
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingState) {
          final textColor =
              settingState.isDarkMode ? Colors.white : Colors.black;
          return CustomContainer(
            backgroundColor:
                settingState.isDarkMode ? secondaryColor : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: user.objectId!,
                      child: CustomContainer(
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
                          imageUrl: user.profileImageUrl != null
                              ? user.profileImageUrl!
                              : "https://ui-avatars.com/api/?name=${user.firstname}+${user.lastname}",
                        ),
                      ),
                    ),
                    2.w.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${user.firstname} ${user.lastname}',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              2.w.pw,
                              Text(
                                'FCFA ${user.pricePerHr}/hr',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              )
                            ],
                          ),
                          1.h.ph,
                          Row(
                            children: [
                              Icon(
                                LineIcons.star,
                                color: Colors.orange,
                                size: 10.sp,
                              ),
                              2.w.pw,
                              Text(
                                '5.0 (11 Reviews)',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          // 1.h.ph,
                          // Row(
                          //   children: [
                          //     Icon(
                          //       LineIcons.checkCircle,
                          //       color: Colors.orange,
                          //       size: 10.sp,
                          //     ),
                          //     2.w.pw,
                          //     Text(
                          //       '9 waiting inline jobs',
                          //       style: TextStyle(
                          //         fontSize: 10.sp,
                          //         color: textColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          1.h.ph,
                          Row(
                            children: [
                              Icon(
                                LineIcons.clock,
                                color: Colors.orange,
                                size: 10.sp,
                              ),
                              2.w.pw,
                              Text(
                                '2 hours minimum required',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          1.h.ph,
                          Text(
                            'Available',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                1.5.h.ph,
                Text(
                  '${user.skills}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
                1.h.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        'See Profile',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        LineIcons.heartAlt,
                        size: 15.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
