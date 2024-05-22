
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import 'PopularServiceCard.dart';

class PopularService extends StatelessWidget {
  const PopularService({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            PopularServiceCard(url: 'assets/images/cattoc_home.jpg',title: S.of(context).home_CatToc,price: 60000,),
            PopularServiceCard(url: 'assets/images/taokieu_home.jpeg', title: S.of(context).home_TaoKieu,price: 50000,),
            PopularServiceCard(url: 'assets/images/nhuomtoc_home.jpg', title: S.of(context).home_NhuomToc,price: 300000,),
          ],
        ),
      ),
    );
  }
}
