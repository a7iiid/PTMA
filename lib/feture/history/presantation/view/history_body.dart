import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/feture/history/data/repo/history_repo_implemant.dart';
import 'package:ptma/feture/history/presantation/manegar/cubit/history_cubit.dart';

class HistoryBody extends StatelessWidget {
  HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryCubit(historyRepo: HistoryRepoImplemant())..getHistory(),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          var cubit = HistoryCubit.get(context);

          if (state is HistorySuccess) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: cubit.history.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(cubit.history[index].tripNam),
                          subtitle: Text(cubit.history[index].price),
                          trailing:
                              Text(cubit.history[index].dateTrip.toString()),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                )
              ],
            );
          } else if (state is HistoryFiluer) {
            return state.error;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
