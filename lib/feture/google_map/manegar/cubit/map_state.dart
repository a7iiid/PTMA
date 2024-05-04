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

final class LodeingStation extends MapState {}

final class SuccessLoding extends MapState {}

final class FiluerLoding extends MapState {}

final class SetStationOnMap extends MapState {}

final class SuccessSetStation extends MapState {}

final class SetSelectedBus extends MapState {}

final class MapClear extends MapState {}

final class BusModelsUpdated extends MapState {}
