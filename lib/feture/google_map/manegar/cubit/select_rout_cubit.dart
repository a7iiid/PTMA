import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:ptma/feture/google_map/data/model/distance_model/distance_model.dart';

import '../../../../core/utils/apiKey.dart';
import '../../data/model/bus_model.dart';
import '../../data/model/station_model.dart';

part 'select_rout_state.dart';

class SelectRoutCubit extends Cubit<SelectRoutState> {
  SelectRoutCubit() : super(SelectRoutInitial());
  static SelectRoutCubit get(context) =>
      BlocProvider.of<SelectRoutCubit>(context);

////////////////////////////////////////
  List<BusModel> busModels = [];
  List<BusModel> listBusFilter = [];
  StationModel? sourceStation;
  StationModel? distnationStation;
  Dio dio = Dio();

////////////////////////////////////

  Stream<List<BusModel>> streamBusModels() async* {
    yield* FirebaseFirestore.instance
        .collection('bus')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) =>
                BusModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  void loadBusModels() async {
    streamBusModels().listen((fetchedBusModels) async {
      try {
        log(fetchedBusModels.toString());

        busModels = fetchedBusModels;
        for (var busModel in fetchedBusModels) {
          final busLocation = LatLng(
              busModel.busLocation.latitude, busModel.busLocation.longitude);
          final destinationLocation = LatLng(
              busModel.endStation.latitude, busModel.endStation.longitude);

          busModel.duration = await destans(busLocation, destinationLocation);
          log(busModel.duration.toString());
          log(busModel.duration.toString());
        }
        emit(StreamBusModel(busModel: fetchedBusModels));
      } catch (e) {
        // Handle error
        log("Error loading bus models: $e");
      }
    });
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
    busModels.forEach((element) {
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

  Future<DistanceModel> destans(LatLng destination, LatLng source) async {
    String baseUrlDistanceMatrix =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${source.latitude},${source.longitude}&key=${ApiKey.mapApiKey}';
    try {
      Response response = await dio.get(baseUrlDistanceMatrix);
      log(response.data.toString()); // Log the response data for debugging
      DistanceModel result =
          DistanceModel.fromJson(response.data as Map<String, dynamic>);
      log(result.toString());
      return result;
    } on Exception catch (e) {
      log("Error fetching distance: $e");
      throw Exception("Error fetching distance: $e");
    }
  }
}
