import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptma/drawer/drawer.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              body: AppCubit.get(context)
                  .pages[AppCubit.get(context).selectedPage],
              bottomNavigationBar: BottomNavigationBar(
                items: AppCubit.get(context).bottomItems,
                currentIndex: AppCubit.get(context).selectedPage,
                onTap: (index) {
                  AppCubit.get(context).onTapNav(index);
                },
                selectedItemColor: Colors.blue,
              ),
              drawer: CustomeDrawer(),
            );
          },
        ),
      ),
    );
  }
}
