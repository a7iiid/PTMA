import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../google_map/data/model/station_model.dart';
import '../../../../google_map/manegar/cubit/map_cubit.dart';

class DropMenuItem extends StatefulWidget {
  DropMenuItem({super.key, required this.location, required this.onChanged});

  final StationModel? location;
  final ValueChanged<StationModel?> onChanged;

  @override
  State<DropMenuItem> createState() => _DropMenuItemState();
}

class _DropMenuItemState extends State<DropMenuItem> {
  void initState() {
    var station = MapCubit.get(context).stationModel;
    stationModel = station
        .map((station) => DropdownMenuItem<StationModel>(
              value: station,
              child: Text(station.name),
            ))
        .toList();
    super.initState();
  }

  List<DropdownMenuItem<StationModel>>? stationModel;
  StationModel? _selectedStation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return DropdownButtonFormField<StationModel>(
          padding: EdgeInsets.zero,
          items: stationModel,
          isDense: true,
          hint: Text("Select "),
          value: _selectedStation,
          onChanged: (newValue) {
            setState(() {
              _selectedStation = newValue;
              widget.onChanged(newValue);
            });
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * .9, maxHeight: 50),
            filled: true,
            fillColor: Colors.white,
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            hoverColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
          ),
        );
      },
    );
  }
}
