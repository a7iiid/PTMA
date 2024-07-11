import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ptma/feture/google_map/data/model/Driver.dart';

part 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit() : super(DriverInitial());
  static DriverCubit get(context) => BlocProvider.of(context);
  FirebaseFirestore instance = FirebaseFirestore.instance;
  List<Driver> drivers = [];

  //to get driver data from firebase
  Future<void> loadDriver() async {
    emit(DriverLoading());
    try {
      QuerySnapshot querySnapshot = await instance.collection('Users').get();
      log(querySnapshot.toString());
      drivers = querySnapshot.docs.map((doc) {
        return Driver.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      emit(DriverLoaded(drivers: drivers));
    } catch (e) {
      emit(DriverFailure(error: e.toString()));
    }
  }
}
