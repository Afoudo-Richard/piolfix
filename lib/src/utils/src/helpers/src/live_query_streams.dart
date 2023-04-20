import 'dart:async';

import 'package:poilfix/poilfix.dart';

class LiveQueryStreams {
  LiveQueryStreams._();

  factory LiveQueryStreams() {
    return _instance;
  }

  static final LiveQueryStreams _instance = LiveQueryStreams._();
  static LiveQueryStreams get instance => _instance;

  static final userUpdateStream = StreamController<User>.broadcast();
  static final titleCtlr = StreamController<String>.broadcast();
  static final bodyCtlr = StreamController<String>.broadcast();

  static dispose() {
    userUpdateStream.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
