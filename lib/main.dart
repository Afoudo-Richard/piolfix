import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poilfix/app.dart';
// adf
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:poilfix/poilfix.dart';
import 'firebase_options.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    requestForNotificationPermission();
    initializeAwesomeNotification();

    FCM.setNotifications();

    await registerParseServer();

    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    HydratedBlocOverrides.runZoned(
      () => runApp(App()),
      storage: storage,
    );
  }, (error, stackTrace) {});
}

registerParseServer() async {
  const keyApplicationId = 'Uqc9HYgHwTrE6nyBJl9zMPZi5pZE5lyQalWaDcr1';
  const keyClientKey = 'dRCisEpybrKkwzoEnJmzayHlbLoGtbKnKVJL3kA8';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true, // When enabled, prints logs to console
    // liveQueryUrl: keyLiveQueryUrl, // Required if using LiveQuery
    autoSendSessionId: true, // Required for authentication and ACL
    // securityContext: securityContext, // Again, required for some setups
  );

  ParseCoreData().registerUserSubClass(
    (username, password, emailAddress, {client, debug, sessionToken}) => User(
      username: username,
      password: password,
      email: emailAddress,
    ),
  );

  // ParseCoreData().registerSubClass(Vehicle.keyTableName, () => Vehicle());
}

void initializeAwesomeNotification() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );
}

void requestForNotificationPermission() {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
