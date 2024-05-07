import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/cach/cach_helpar.dart';

part 'loclaization_state.dart';

class LoclaizationCubit extends Cubit<LoclaizationState> {
  LoclaizationCubit() : super(LoclaizationInitial());

  static LoclaizationCubit get(context) =>
      BlocProvider.of<LoclaizationCubit>(context);
  bool isArabic = false;

  void changeLang(bool lang) {
    emit(LoclaizationInitial());
    isArabic = lang;
    CachHelper.langPutData('isArabic', isArabic);
    emit(Languegchang());
  }
}
