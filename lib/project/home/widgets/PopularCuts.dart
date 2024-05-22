import 'package:doan_barberapp/project/home/widgets/PopularCutCard.dart';
import 'package:doan_barberapp/shared/models/PopularCutItem.dart';
import 'package:flutter/material.dart';

class PopularCuts extends StatelessWidget {
  const PopularCuts({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'assets/images/BuzzCut.jpg',title: 'Buzz Cut')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'assets/images/Pompadour.jpg',title: 'Pompadour')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'assets/images/CombOver.jpg',title: 'Comb Over')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'assets/images/FauxHawk.jpeg',title: 'Faux Hawk')),
          ],
        ),
      ),
    );
  }
}
