# Your pubspec.yaml file

## dependencies

  flutter_localizations:
    sdk: flutter
  intl: ^0.17.0
  sizer: ^2.0.15
  http: ^0.13.4
  cached_network_image: ^3.2.1
  path_provider: ^2.0.11
  hydrated_bloc: ^8.1.0
  share_plus: ^4.0.10
  validators: ^3.0.0
  stream_transform: ^2.0.0
  image_picker: ^0.8.3+3   # may remove
  url_launcher: ^6.1.5
  awesome_notifications: ^0.7.4+1
  connectivity_wrapper: ^1.1.0


## dev_dependencies
  flutter_bloc: ^8.0.1
  formz: ^0.4.0
  equatable: ^2.0.0
  flutter_launcher_icons: ^0.11.0

## flutter section

flutter:
  generate: true
  uses-material-design: true

  assets:
    - assets/images/
    - assets/translations/

## for creating icons
flutter_icons:
  android: "ic_launcher"
  adaptive_icon_background: "assets/images/logo.png"
  ios: true
  image_path: "assets/images/logo.png"


## update sdk (important)

  minSdkVersion 21//flutter.minSdkVersion
  targetSdkVersion 33 //flutter.targetSdkVersion