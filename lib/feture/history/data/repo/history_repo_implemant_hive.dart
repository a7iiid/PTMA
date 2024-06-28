import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';
import 'package:ptma/feture/history/data/model/history_service.dart';
import 'package:ptma/feture/history/data/repo/history_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryRepoImplemantHive extends HistoryRepo {
  @override
  Future<Either<Widget, List<HistoryModel>>> getHistory() async {
    try {
      List<HistoryModel> notes = await HistoryService.get().getAllHistory();
      return right(notes);
    } on Exception catch (e) {
      // TOD
      return left(const Center(
        child: Text("has Error"),
      ));
    }
  }
}
