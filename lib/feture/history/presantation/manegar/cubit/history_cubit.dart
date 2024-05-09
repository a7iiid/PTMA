import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';
import 'package:ptma/feture/history/data/repo/history_repo.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepo historyRepo;
  HistoryCubit({required this.historyRepo}) : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of<HistoryCubit>(context);
  List<HistoryModel> history = [];
  Future<void> getHistory() async {
    emit(HistoryLoading());
    var result = await historyRepo.getHistory();
    result.fold((filuer) {
      emit(HistoryFiluer(error: filuer));
    }, (notes) {
      if (notes == null) {
        emit(HistoryNull());
      }
      history = notes;
      emit(HistorySuccess(
        history: history,
      ));
    });
  }
}
