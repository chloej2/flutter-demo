# flutter_demo

The project aim is to create a mobile application that shows a list of users which links to a gallery of their images.

It has the following specifications:
* Display a list of names from http://jsonplaceholder.typicode.com/users.
* When a name is clicked, show a collection of album images with album title from http://jsonplaceholder.typicode.com/photos.
* When an image is clicked, show a full size image which takes most of the screen.
* Animation (gallery and full page image transitions) and UI/UX

## Dependencies
* [Flutter](https://flutter.dev/)
* [Dart HTTP](https://pub.dev/packages/http)
* [GetX](https://pub.dev/packages/get)
* [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations)
* [flutter_profile_picture](https://pub.dev/packages/flutter_profile_picture)

## Requirements
Any Operating System (ie. MacOS X, Linux, Windows)
Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)

## Getting Started
For help getting started with Flutter, view the [online documentation](https://flutter.io/).

If you encounter the Error: Cannot run with sound null safety.

Change settings below:
 Code => Preferences => Settings => Search setting, type in "flutter test" => Dart: Flutter Test Additional Args, Add item => Add "--no-sound-null-safety"
