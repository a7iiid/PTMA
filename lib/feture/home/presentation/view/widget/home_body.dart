import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ptma/core/utils/Style.dart';
import 'package:ptma/core/utils/images.dart';
import 'package:ptma/core/utils/localization/app_localaization.dart';
import 'package:ptma/core/widget/custom_button.dart';
import 'package:ptma/core/utils/drawer/drawer.dart';
import 'package:ptma/feture/google_map/view/homemap.dart';
import 'package:ptma/feture/home/presentation/manger/cubit/app_cubit.dart';
import 'package:ptma/feture/home/presentation/view/widget/drawer_bottom.dart';
import 'package:ptma/feture/home/presentation/view/widget/head_home_page.dart';
import 'package:ptma/feture/home/presentation/view/widget/map_route_bus.dart';

import '../../../../../core/utils/rout.dart';
import 'greetingslogin.dart';

class HomeBody extends StatelessWidget {
  HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Stack(
          clipBehavior: Clip.none,
          children: [
            HeadHomePage(),
            DrawerBottom(),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .1,
        ),
        CustomButton(
            title: 'View map'.tr(context),
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(),
                ),
              );
            }),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .1,
        ),
        CustomButton(
            title: 'select rout'.tr(context),
            function: () {
              GoRouter.of(context).push(Routes.kSelectRouts);
            }),
      ],
    );
  }
}
