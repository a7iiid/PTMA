import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/map_route_bus.dart';

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
                    ? cubit.busModels.length
                    : cubit.listBusFilter.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue[50],
                    child: ListTile(
                      title: Text(cubit.listBusFilter.isEmpty
                          ? cubit.busModels[index].busname
                          : cubit.listBusFilter[index].busname),
                      subtitle: Text(cubit.listBusFilter.isEmpty
                          ? cubit.busModels[index].busnumber
                          : cubit.listBusFilter[index].busnumber),
                      trailing: Text(
                          "${cubit.busModels[index].duration?.durationText}"),
                      onTap: () async {
                        try {
                          // var result = await cubit.destans(
                          //     distnationLocation, busLocation);
                          // cubit.busModel[index].duration = result;
                          var select = cubit.listBusFilter.isEmpty
                              ? cubit.busModels[index]
                              : cubit.listBusFilter[index];

                          MapCubit.get(context).setSelectedBus(select);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapRouteBus()),
                          );
                        } catch (e) {
                          // Handle error
                        }
                      },
                    ),
                  );
                }));
      },
    );
  }
}
