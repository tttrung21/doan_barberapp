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
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'https://www.liveabout.com/thmb/kwUlFmtrrE-86-oLV4TWgVMEtaI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/zayn-01-56a610a95f9b58b7d0dfbf46.jpg',title: 'Buzz Cut')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'https://barbershopvutri.com/wp-content/uploads/2020/05/mau-toc-nam-dep-pompadour-2.jpg',title: 'Pompadour')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'https://www.apetogentleman.com/wp-content/uploads/2022/06/cof-classic-4-720x900.jpg',title: 'Comb Over')),
            const SizedBox(width: 16,),
            PopularCutCard(haircut: PopularCutItem(imageUrl: 'https://barbershopvutri.com/wp-content/uploads/2020/07/David-Beckham-Faux-Hawk-Haircut.jpg',title: 'Faux Hawk')),
          ],
        ),
      ),
    );
  }
}
