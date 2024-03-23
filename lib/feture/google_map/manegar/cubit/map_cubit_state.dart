part of 'map_cubit_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

final class MapLoding extends MapState {}

final class MapCheckService extends MapState {}

final class MapSetLine extends MapState {}

final class MapSetMarker extends MapState {}

final class MapFiluer extends MapState {}

final class MapSuccess extends MapState {}
