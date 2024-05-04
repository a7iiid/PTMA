import 'package:flutter/material.dart';

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
  List<DropdownMenuItem<StationModel>>? stationModel;

  @override
  void didChangeDependencies() async {
    var station = MapCubit.get(context).stationModel;
    stationModel = station
        .map((station) => DropdownMenuItem<StationModel>(
              value: station,
              child: Text(station.name),
            ))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<StationModel>(
      items: stationModel,
      value: widget.location,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .9,
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black, fontSize: 25),
        hoverColor: Colors.white,
      ),
    );
  }
}
