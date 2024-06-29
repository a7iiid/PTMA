part of 'driver_cubit.dart';

@immutable
sealed class DriverState {}

final class DriverInitial extends DriverState {}

final class DriverLoding extends DriverState {}

final class DriverSuccess extends DriverState {}

final class DriverFiluer extends DriverState {}
