import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';

class StationDropdown extends StatefulWidget {
  final List<Marker> stations;
  final ValueChanged<Marker> onChanged;

  const StationDropdown({
    Key? key,
    required this.stations,
    required this.onChanged,
  }) : super(key: key);

  @override
  _StationDropdownState createState() => _StationDropdownState();
}

class _StationDropdownState extends State<StationDropdown> {
  Marker? _selectedStation;

  @override
  void initState() {
    super.initState();
    if (widget.stations.isNotEmpty) {
      _selectedStation = widget.stations.first;
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Marker>(
      value: _selectedStation,
      items: widget.stations
          .map((station) => DropdownMenuItem<Marker>(
                value: station,
                child: Text("${station.markerId.value}"),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedStation = value;
        });
        widget.onChanged(_selectedStation!);
      },
      decoration: const InputDecoration(
        labelText: 'Select station',
        border: OutlineInputBorder(),
      ),
    );
  }
}
