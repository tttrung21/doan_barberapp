import 'package:doan_barberapp/project/home/widgets/HomeHeaderStatus.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: HomeHeaderStatus()),
        SizedBox(width: 8,),
      ],
    );
  }
}
