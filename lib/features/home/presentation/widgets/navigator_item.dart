import 'package:dash_pass/features/home/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorItem extends StatelessWidget {
  final IconData icon;
  final int index;
  const NavigatorItem({
    super.key,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final navigationIndex = context.watch<NavigationCubit>().state;
    return Icon(
      icon,
      color: navigationIndex == index ? Colors.white : const Color(0xffB0B0B0),
      size: 30,
    );
  }
}
