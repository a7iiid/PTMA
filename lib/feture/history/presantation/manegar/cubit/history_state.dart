part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistorySuccess extends HistoryState {
  final List<HistoryModel> history;

  HistorySuccess({required this.history});
}

final class HistoryNull extends HistoryState {}

final class HistoryFiluer extends HistoryState {
  final Widget error;

  HistoryFiluer({required this.error});
}
