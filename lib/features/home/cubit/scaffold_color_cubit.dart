import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaffoldColorCubit extends Cubit<Color> {
  ScaffoldColorCubit() : super(const Color(0xff0B6D6D));

  void changeIndexValue(Color value) {
    emit(value);
  }
}
