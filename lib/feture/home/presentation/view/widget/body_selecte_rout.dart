import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/map_route_bus.dart';

class bodySelecteRout extends StatelessWidget {
  const bodySelecteRout({
    super.key,
    required this.cubit,
  });

  final SelectRoutCubit cubit;

  @override
  Widget build(BuildContext context) {
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
                subtitle: Text(cubit.listBusFilter.isEmpty
                    ? cubit.busModel[index].busnumber
                    : cubit.listBusFilter[index].busnumber),
                // trailing: Text(cubit.busModel[index].bustime,
                // ),
                onTap: () {
                  MapCubit.get(context).setSelectedBus(
                      cubit.listBusFilter.isEmpty
                          ? cubit.busModel[index]
                          : cubit.listBusFilter[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapRouteBus(
                            busModel: MapCubit.get(context).selectedBus)),
                  );
                },
              ),
              const Divider()
            ],
          );
        },
      ),
    );
  }
}
