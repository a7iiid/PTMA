import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StationDropdown extends StatefulWidget {
  final List<Marker> stations;
  final Function(Marker) onChanged;

  StationDropdown({required this.stations, required this.onChanged});

  @override
  _StationDropdownState createState() => _StationDropdownState();
}

class _StationDropdownState extends State<StationDropdown> {
  late Marker _selectedStation;

  @override
  void initState() {
    _selectedStation = widget.stations.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Marker>(
      value: _selectedStation,
      items: widget.stations
          .map((station) => DropdownMenuItem<Marker>(
                value: station,
                child: Text('${station.markerId}'),
              ))
          .toList(),
      onChanged: (Marker? value) {
        if (value != null) {
          setState(() {
            _selectedStation = value;
            widget.onChanged(_selectedStation);
          });
        }
      },
    );
  }
}
