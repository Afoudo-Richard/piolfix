import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            4.h.ph,
            Row(
              children: [
                CustomContainer(
                  padding: EdgeInsets.zero,
                  height: 50.sp,
                  width: 50.sp,
                  child: Image.asset(
                    'assets/images/user1.jpeg',
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                2.w.pw,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mubuifor Marcellus",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "marcellus@gmail.com",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )),
                Icon(
                  LineIcons.edit,
                  color: primaryColor,
                ),
              ],
            ),
            5.h.ph,
            ItemTile(
              icon: LineIcons.bell,
              title: "Add Category",
              onTap: () => Navigator.push(
                context,
                CategoryAddPage.route(),
              ),
            ),
            ItemTile(
              icon: LineIcons.bell,
              title: "Notification",
            ),
            ItemTile(
              icon: LineIcons.cog,
              title: "settings",
            ),
            ItemTile(
              icon: LineIcons.scroll,
              title: "Terms & condition",
            ),
            ItemTile(
              icon: LineIcons.userShield,
              title: "Privacy policy",
            ),
            ItemTile(
              icon: LineIcons.users,
              title: "About Us",
            ),
            ItemTile(
              icon: LineIcons.headset,
              title: "Contact Us",
            ),
            ItemTile(
              icon: LineIcons.mobilePhone,
              title: "App Info",
            ),
          ],
        ),
      ),
    );
  }
}
