import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/feture/history/data/model/history_model.dart';
import 'package:ptma/feture/history/data/repo/history_repo.dart';

import '../../../../payment/stripe/model/BusTrip.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepo historyRepo;
  HistoryCubit({required this.historyRepo}) : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of<HistoryCubit>(context);
  List<HistoryModel> history = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> addPassengerToTrip(
      BusTrip qrCodeData, String passengerName, String passengerEmail) async {
    try {
      // Reference to the specific trip document in Firestore
      DocumentReference tripDoc =
          _firestore.collection('Trips').doc(qrCodeData.tripid.toString());
      log(tripDoc.toString());

      // Get the current trip data
      DocumentSnapshot tripSnapshot = await tripDoc.get();

      if (tripSnapshot.exists) {
        // Update the passengers array in the trip document
        await tripDoc.update({
          'passengers': FieldValue.arrayUnion([
            {
              'name': passengerName,
              'email': passengerEmail,
            }
          ])
        });

        print('Passenger added successfully.');
      } else {
        print('Trip not found.');
      }
    } catch (e) {
      print('Error adding passenger: $e');
    }
  }
}
