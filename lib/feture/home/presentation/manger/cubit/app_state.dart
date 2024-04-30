part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class AppChangeScreen extends AppState {
  final int activeTab;

  AppChangeScreen({required this.activeTab});
}

class Languegchang extends AppState {}

class ChangeUserPictiurLoding extends AppState {}

class ChangeUserPictiurSuccess extends AppState {}

class ChangeUserPictiurFilur extends AppState {}
