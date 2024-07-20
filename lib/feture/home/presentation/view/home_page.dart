import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/feture/google_map/manegar/cubit/driver_cubit.dart';
import 'package:ptma/feture/google_map/manegar/cubit/map_cubit.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    MapCubit mapCubit = MapCubit.get(context);
    return SafeArea(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: cubit.pages[cubit.selectedPage],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.selectedPage,
              onTap: (index) {
                cubit.onTapNav(index, context);
              },
              selectedItemColor: Colors.blue,
            ),
            drawer: const CustomeDrawer(),
          );
        },
      ),
    );
  }
}
