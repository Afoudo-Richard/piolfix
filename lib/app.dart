import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import "package:flutter/material.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poilfix/poilfix.dart';
import 'package:poilfix/src/blocs/src/tasker_profile_info/bloc/tasker_profile_info_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PoilfixApi(),
        ),
        RepositoryProvider(
          create: (context) => CamPayApi(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsBloc()),
          BlocProvider(create: (context) => AuthenticationBloc()),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(create: (context) => AppBottomNavigationBarBloc()),
          BlocProvider(create: (context) => CategoryAddBloc()),
          BlocProvider(
              create: (context) => UserImageBloc(
                    userBloc: BlocProvider.of<UserBloc>(context),
                  )),
          BlocProvider(
              create: (context) => TaskerListBloc()..add(TaskerListFetched())),
          BlocProvider(
              create: (context) => TaskerProfileInfoBloc(
                  userBloc: BlocProvider.of<UserBloc>(context))),
          BlocProvider(
            create: (context) => CategoryListBloc()..add(CategoryListFetched()),
            lazy: false,
          ),
          BlocProvider(create: (context) => SelectTaskBloc()),
          BlocProvider(
              create: (context) => MobileMoneyBloc(
                  camPayApi: RepositoryProvider.of<CamPayApi>(context))),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ConnectivityAppWrapper(
          app: MaterialApp(
            title: 'PiolFix',
            // locale: context.locale,
            supportedLocales: const [
              Locale('en'), // English, no country code
              Locale('fr'), // Spanish, no country code
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            navigatorKey: _navigatorKey,
            theme: appTheme(context),
            builder: (context, child) {
              return GlobalScaffold(
                child: InternetConnectivityWidgetWrapper(
                  child: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      Future.delayed(
                        const Duration(microseconds: 500),
                        () {
                          if (state.authenticated ||
                              state.isSignedInAnonymous) {
                            _navigator.pushAndRemoveUntil<void>(
                              MainScreen.route(),
                              (route) => false,
                            );
                            BlocProvider.of<AppBottomNavigationBarBloc>(context)
                                .add(
                              AppBottomNavigationBarChanged(
                                activePage: const HomePage(),
                              ),
                            );
                          } else {
                            if (state.hasWalkedThrough) {
                              _navigator.pushAndRemoveUntil<void>(
                                LoginPage.route(),
                                (route) => false,
                              );
                            } else {
                              _navigator.pushAndRemoveUntil<void>(
                                WalkThroughPage.route(),
                                (route) => false,
                              );
                              BlocProvider.of<AppBottomNavigationBarBloc>(
                                      context)
                                  .add(
                                AppBottomNavigationBarChanged(
                                  activePage: const HomePage(),
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                    child: child,
                  ),
                ),
              );
            },
            onGenerateRoute: (_) {
              final state = context.read<AuthenticationBloc>().state;
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationChecker(check: !(state.checker)));
              return SplashPage.route();
            },
          ),
        );
      },
    );
  }
}
