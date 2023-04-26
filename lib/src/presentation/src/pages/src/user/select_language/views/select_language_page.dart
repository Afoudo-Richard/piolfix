import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectLanguagePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: trans(context)!.select_language,
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            3.h.ph,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        trans(context)!.select_language,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        state.locale.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      barrierColor: primaryColor.withOpacity(0.6),
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) {
                        return const AllLanguages();
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, -8),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(context, WalkThroughPage.route());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        trans(context)!.proceed,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          letterSpacing: 1.5,
                        ),
                      ),
                      2.w.pw,
                      Icon(
                        Icons.arrow_forward,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
