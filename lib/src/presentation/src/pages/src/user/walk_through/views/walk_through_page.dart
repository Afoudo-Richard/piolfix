import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poilfix/poilfix.dart';

class WalkThroughPage extends StatelessWidget {
  WalkThroughPage({
    super.key,
  });

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WalkThroughPage());
  }

  @override
  Widget build(BuildContext context) {
    final List<OnbordingData> list = [
      onbordingDateWrapper(
        image: Image.asset(
          "assets/images/welcome_2.png",
          width: 50.w,
        ),
        title: trans(context)!.welcome,
        description:
            "Come let's go into a new world of task outsourcing for you.",
      ),
      onbordingDateWrapper(
        image: Image.asset(
          "assets/images/welcome_3.png",
          width: 50.w,
        ),
        title: trans(context)!.too_much_task,
        description: trans(context)!.too_much_task_message,
      ),
      onbordingDateWrapper(
        image: Image.asset(
          "assets/images/welcome_4.png",
          width: 50.w,
        ),
        title: trans(context)!.outsource,
        description: trans(context)!.outsource_message,
      ),
    ];
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      selectedDotColor: primaryColor,
      navigatorPadding: SizerUtil.deviceType == DeviceType.mobile
          ? EdgeInsets.symmetric(horizontal: 28.sp, vertical: 10)
          : EdgeInsets.symmetric(horizontal: 14.sp, vertical: 10),
      colors: const [
        //list of colors for per pages
        Colors.white,
        primaryColor,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      nextButton: CustomContainer(
        borderRadius: BorderRadius.circular(5),
        padding: const EdgeInsets.all(10),
        backgroundColor: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineIcons.arrowRight,
              size: 12,
              color: Colors.white,
            ),
          ],
        ),
      ),
      lastButton: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            const AuthenticationHasWalkedThroughChanged(
              hasWalkedThrough: true,
            ),
          );
          // _showWelcomeMessage();
        },
        child: CustomContainer(
          borderRadius: BorderRadius.circular(5),
          padding: EdgeInsets.all(10),
          backgroundColor: secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trans(context)!.get_started,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
              2.w.pw,
              Icon(
                Icons.arrow_forward,
                size: 12,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      skipButton: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            const AuthenticationHasWalkedThroughChanged(
              hasWalkedThrough: true,
            ),
          );
          // _showWelcomeMessage();
        },
        child: Text(
          trans(context)!.skip,
          style: TextStyle(
            color: Color(0XFF7B7879),
            fontSize: 14,
          ),
        ),
      ),
      unSelectdDotColor: Colors.grey,
    );
  }
}

_showWelcomeMessage() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'PiolFix',
        body:
            'Hey welcome to EasyMove, Let us move you to where ever you want to go',
        actionType: ActionType.Default),
  );
}

OnbordingData onbordingDateWrapper({
  required Widget image,
  required String title,
  required String description,
}) {
  return OnbordingData(
    image: image,
    titleText: SizedBox(
      width: 70.sp,
      child: Image.asset("assets/images/logo1_trans.png"),
    ),
    descText: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          description,
          style: TextStyle(
            color: const Color(0XFF7B7879),
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 6.sp,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    imageHeight: 55.h,
    descPadding: SizerUtil.deviceType == DeviceType.mobile
        ? EdgeInsets.symmetric(horizontal: 25.sp)
        : EdgeInsets.symmetric(horizontal: 14.sp),
  );
}
