import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(2);

  void changeIndexValue(int value) {
    emit(value);
  }
}
