import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/map_route_bus.dart';

import '../../../../google_map/data/model/distance_model/distance_model.dart';

class bodySelecteRout extends StatelessWidget {
  const bodySelecteRout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);
    return BlocBuilder<SelectRoutCubit, SelectRoutState>(
      builder: (context, state) {
        return Expanded(
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
                    ////
                    subtitle: Text(cubit.listBusFilter.isEmpty
                        ? cubit.busModel[index].busnumber
                        : cubit.listBusFilter[index].busnumber),
                    // trailing: Text(cubit.busModel[index].bustime,
                    // ),
                    onTap: () {
                      var select = cubit.listBusFilter.isEmpty
                          ? cubit.busModel[index]
                          : cubit.listBusFilter[index];

                      MapCubit.get(context).setSelectedBus(select);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapRouteBus()),
                      );
                    },
                  ),
                  const Divider()
                ],
              );
            },
          ),
        );
      },
    );
  }
}
