import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';

abstract class HistoryRepo {
  Future<Either<Widget, List<HistoryModel>>> getHistory();
}
