import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const AboutAppPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingState) {
        return CustomScaffold(
          appBar: const CustomAppBar(
            title: "About App",
          ),
          body: SizedBox(
            width: double.infinity,
            height: 100.h,
            child: Padding(
              padding: pagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      6.h.ph,
                      AppLogo(
                        width: 20.w,
                      ),
                      3.h.ph,
                      Text(
                        "PioFix is an on demand service platform that serves as a platform to link service providers with available freelancers or service seekers. It aims to bridge the gab in the market and help find the perfect person to outsource your project or task.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: settingState.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      3.h.ph,
                      // Text(
                      //   "Contact us: piolfix@gmail.com",
                      //   style: TextStyle(
                      //     fontSize: 10.sp,
                      //     color: settingState.isDarkMode
                      //         ? Colors.white
                      //         : Colors.black,
                      //   ),
                      // ),
                      // 1.h.ph,
                      // Text(
                      //   "Phone: +237-672-367-020 / +237-693-386-383",
                      //   style: TextStyle(
                      //     fontSize: 10.sp,
                      //     color: settingState.isDarkMode
                      //         ? Colors.white
                      //         : Colors.black,
                      //   ),
                      // ),
                      3.h.ph,
                      Text(
                        "if you faced any problems while using our app, please try to restore it to the default settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                      4.h.ph,
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Version: 1.0.0",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: settingState.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      2.h.ph,
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
