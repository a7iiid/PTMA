part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoding extends MapState {}

final class MapCheckService extends MapState {}

final class MapSetLine extends MapState {}

final class MapSetMarker extends MapState {}

final class MapFiluer extends MapState {}

final class MapSuccess extends MapState {}

final class SelectRout extends MapState {}

final class FiltringBus extends MapState {}
