part of 'select_rout_cubit.dart';

@immutable
sealed class SelectRoutState {}

final class SelectRoutInitial extends SelectRoutState {}

final class FiltringBus extends SelectRoutState {}

final class LodingBus extends SelectRoutState {}

final class LodingBusSuccess extends SelectRoutState {}

final class LodingBusFiluer extends SelectRoutState {}

final class UpdateStation extends SelectRoutState {}
