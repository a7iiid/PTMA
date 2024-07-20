import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../payment/stripe/model/BusTrip.dart';
import '../../../data/history.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of<HistoryCubit>(context);
  List<History> history = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> getHistory() async {
  //   emit(HistoryLoading());
  //   var result = await historyRepo.getHistory();
  //   result.fold((filuer) {
  //     emit(HistoryFailure(error: filuer));
  //   }, (notes) {
  //     if (notes == null) {
  //       emit(HistoryNull());
  //     }
  //     history = notes;
  //     emit(HistorySuccess(
  //       history: history,
  //     ));
  //   });
  // }

  Future<void> addPassengerToTrip(
      BusTrip qrCodeData, String passengerEmail) async {
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
            passengerEmail,
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

  Future<void> loadTripsForCurrentUser() async {
    try {
      emit(HistoryLoading());

      // Get the current logged-in user's email
      User? currentUser = FirebaseAuth.instance.currentUser;
      String? userEmail = currentUser?.email;

      if (userEmail == null) {
        emit(HistoryFailure(error: Text('User not logged in')));
        return;
      }

      // Log the current user's email
      log('Current user email: $userEmail');

      // Query the trips collection for documents where the passengers array contains the user's email
      QuerySnapshot querySnapshot = await _firestore
          .collection('Trips')
          .where('passengers', arrayContains: userEmail)
          .get();

      // Log the number of documents found
      log('Number of documents found: ${querySnapshot.docs.length}');

      // Log each document's data
      for (var doc in querySnapshot.docs) {
        log('Document data: ${doc.data()}');
      }

      // Convert the documents to History objects
      List<History> userTrips = querySnapshot.docs.map((doc) {
        return History.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (userTrips.isEmpty) {
        emit(HistoryNull());
      } else {
        emit(HistorySuccess(history: userTrips));
      }
    } catch (e) {
      emit(HistoryFailure(error: Text('Error loading trips: $e')));
    }
  }
}
