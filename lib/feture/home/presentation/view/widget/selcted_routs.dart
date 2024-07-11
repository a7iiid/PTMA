
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';

import '../../../../google_map/data/model/station_model.dart';
import 'body_selecte_rout.dart';
import 'drawer_bottom.dart';
import 'head_home_page.dart';
import 'station_menue.dart';

class SelectRouts extends StatefulWidget {
  SelectRouts({super.key});

  @override
  State<SelectRouts> createState() => _SelectRoutsState();
}

class _SelectRoutsState extends State<SelectRouts> {
  final TextEditingController iconController = TextEditingController();

  StationModel? sourseStation;

  StationModel? distnationStation;

  List<DropdownMenuItem<StationModel>>? stationModel;

  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);

    return Scaffold(
        drawer: CustomeDrawer(),
        body: SafeArea(
            child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HeadHomePage(),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .05,
                  child: const DrawerBottom(),
                ),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .1,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropMenuItem(
                            location: sourseStation,
                            onChanged: (value) {
                              sourseStation = value;

                              SelectRoutCubit.get(context)
                                  .updateSourceStation(value);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropMenuItem(
                            location: distnationStation,
                            onChanged: (value) {
                              distnationStation = value;

                              SelectRoutCubit.get(context)
                                  .updateDistnationStation(value);
                            },
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<SelectRoutCubit, SelectRoutState>(
                listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is LodingBus) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StreamBusModel) {
                return const bodySelecteRout();
              } else {
                SelectRoutCubit.get(context).loadBusModels();
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ],
        )));
  }
}
