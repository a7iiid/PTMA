import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/apiKey.dart';
import '../../data/model/bus_model.dart';
import '../../data/model/station_model.dart';

part 'select_rout_state.dart';

class SelectRoutCubit extends Cubit<SelectRoutState> {
  SelectRoutCubit() : super(SelectRoutInitial());
  static SelectRoutCubit get(context) =>
      BlocProvider.of<SelectRoutCubit>(context);

////////////////////////////////////////
  List<BusModel> busModel = [];
  List<BusModel> listBusFilter = [];
  StationModel? sourseStation;
  StationModel? distnationStation;
  Dio dio = Dio();

////////////////////////////////////
  Future<void> getBusFromFireBase() async {
    try {
      emit(LodingBus());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bus')
          .where('isActive', isEqualTo: true)
          .get();

      var buses = querySnapshot.docs;
      var busData = buses
          .map((doc) => BusModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      busModel.addAll(busData);
      emit(LodingBusSuccess());
    } on Exception catch (e) {
      emit(LodingBusFiluer());
      // TODO
    }
  }

  void feltaringBus(LatLng startStation, LatLng endStation) {
    listBusFilter = [];
    emit(FiltringBus());
    busModel.forEach((element) {
      LatLng busStart = LatLng(element.startlatitude, element.startlongitude);
      LatLng busEnd = LatLng(element.endlatitude, element.endlongitude);
      if (busStart == startStation && busEnd == endStation) {
        listBusFilter.add(element);
      }
    });
    print(listBusFilter);
  }

  Future<void> destans(LatLng destination, LatLng start) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${start.latitude},${start.longitude}&key=${ApiKey.mapApiKey}';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      print(response);
    } on Exception catch (e) {
      // TODO
    }
  }
}
