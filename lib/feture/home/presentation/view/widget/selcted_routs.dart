import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/feture/google_map/data/model/bus_model.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/dropdowne.dart';
import 'package:ptma/feture/home/presentation/view/widget/map_route_bus.dart';

import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/rout.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../../google_map/data/model/station_model.dart';
import '../../../../google_map/view/homemap.dart';
import 'head_home_page.dart';
import 'station_menue.dart';

class SelectRouts extends StatelessWidget {
  SelectRouts({super.key});
  final TextEditingController iconController = TextEditingController();
  StationModel? sourseStation;
  StationModel? distnationStation;
  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);
    List<BusModel> listbus =
        cubit.busModel.where((element) => element.isActive == true).toList();

    return BlocBuilder<SelectRoutCubit, SelectRoutState>(
      builder: (context, state) {
        return Scaffold(
          drawer: CustomeDrawer(),
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const HeadHomePage(),
                    // Row(
                    //   children: [
                    //     Builder(builder: (context) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           Scaffold.of(context).openDrawer();
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //             top: 50,
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               const SizedBox(
                    //                 width: 20,
                    //               ),
                    //               SvgPicture.asset(Assets.imagesMenuIcon),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }),

                    //     //const Greetingslogin(),
                    //   ],
                    // ),
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
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.listBusFilter.isEmpty
                        ? cubit.busModel.length
                        : cubit.listBusFilter.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(cubit.listBusFilter.isEmpty
                                ? cubit.busModel[index].busname
                                : cubit.listBusFilter[index].busname),
                            subtitle: Text(cubit.listBusFilter.isEmpty
                                ? cubit.busModel[index].busnumber
                                : cubit.listBusFilter[index].busnumber),
                            // trailing: Text(cubit.busModel[index].bustime,
                            // ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapRouteBus(
                                        busModel: cubit.listBusFilter.isEmpty
                                            ? cubit.busModel[index]
                                            : cubit.listBusFilter[index])),
                              );
                            },
                          ),
                          const Divider()
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
