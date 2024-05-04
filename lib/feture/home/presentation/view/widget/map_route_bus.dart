import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ptma/feture/google_map/data/model/bus_model.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/view/widget/head_home_page.dart';

import 'drawer_bottom.dart';

class MapRouteBus extends StatefulWidget {
  MapRouteBus({super.key, this.busModel});
  BusModel? busModel;

  @override
  State<MapRouteBus> createState() => _MapRouteBusState();
}

class _MapRouteBusState extends State<MapRouteBus> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        MapCubit.get(context).clear();
      },
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bus')
              .where('isActive', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            List<BusModel> busModels = snapshot.data!.docs
                .map((doc) =>
                    BusModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            MapCubit.get(context).updateBusModels(busModels);

            return MapPage(
              busModel: widget.busModel,
            );
          },
        ),
      ),
    );
  }
}
