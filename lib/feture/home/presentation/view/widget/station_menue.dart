import 'package:flutter/material.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/google_map/data/model/station_model.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';

class DropMenuItem extends StatefulWidget {
  DropMenuItem({
    super.key,
    required this.location,
  });

  StationModel? location;

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
              child: Text(station
                  .name), // Replace 'name' with the appropriate property of StationModel
            ))
        .toList();
    widget.location ??= stationModel!.first.value;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<StationModel>(
      items: stationModel,
      value: widget.location,
      onChanged: (value) {
        setState(() {
          widget.location = value as StationModel;
        });
        // widget.onChanged(_selectedStation!);
      },
      decoration: InputDecoration(
        // labelText: 'Select station'.tr(context),
        border: OutlineInputBorder(),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .9,
        ),
        filled: true, // add this
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.black, fontSize: 25),

        hoverColor: Colors.white,
      ),
    );
  }
}
