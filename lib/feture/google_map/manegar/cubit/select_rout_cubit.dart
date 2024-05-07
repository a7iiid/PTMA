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
  StationModel? sourceStation;
  StationModel? distnationStation;
  Dio dio = Dio();

////////////////////////////////////
  ///
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getDataFromFireBase() async {
    emit(LodingBus());
    var query = await FirebaseFirestore.instance
        .collection('bus')
        .where('isActive', isEqualTo: true)
        .snapshots();
    emit(LodingBusSuccess());

    return query;
  }

  void streamActiveBus() {
    emit(LodingBus());
  }

  Future<void> MapDataToBusModel(List<QueryDocumentSnapshot> query) async {
    try {
      emit(LodingBus());

      busModel = query
          .map((doc) =>
              BusModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      //busModel.addAll(busData);
      emit(LodingBusSuccess());
    } on Exception catch (e) {
      emit(LodingBusFiluer());
      // TODO
    }
  }

  void updateSourceStation(StationModel? station) {
    emit(ChangeSourceStation());
    if (station != null) {
      sourceStation = station;
      emit(UpdateStation());
    }
  }

  void updateDistnationStation(StationModel? station) {
    emit(ChangeDistnationStation());

    if (station != null) {
      distnationStation = station;
      feltaringBus(
          LatLng(distnationStation!.stationLocation.latitude,
              distnationStation!.stationLocation.longitude),
          LatLng(sourceStation!.stationLocation.latitude,
              sourceStation!.stationLocation.longitude));
      emit(UpdateStation());
    }
  }

  void feltaringBus(LatLng startStation, LatLng endStation) {
    listBusFilter = [];
    emit(FiltringBus());
    busModel.forEach((element) {
      LatLng busStart =
          LatLng(element.startStation.latitude, element.startStation.longitude);
      LatLng busEnd =
          LatLng(element.endStation.latitude, element.endStation.longitude);

      if (busStart.latitude == startStation.latitude &&
          busStart.longitude == startStation.longitude &&
          busEnd.latitude == endStation.latitude &&
          busEnd.longitude == endStation.longitude) {
        listBusFilter.add(element);
      }
    });
    emit(SuccessFiltringBus());
  }

  Future<void> destans(LatLng destination, LatLng source) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${source.latitude},${source.longitude}&key=${ApiKey.mapApiKey}';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      print(response);
    } on Exception catch (e) {
      // TODO
    }
  }
}
