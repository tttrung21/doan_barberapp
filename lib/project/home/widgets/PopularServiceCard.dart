import 'package:doan_barberapp/shared/models/PopularCutItem.dart';
import 'package:doan_barberapp/utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/skin/color_skin.dart';
import '../../../components/skin/typo_skin.dart';
import '../../../generated/l10n.dart';

class PopularServiceCard extends StatelessWidget {
  const PopularServiceCard({super.key, this.url,this.title, this.price});

  final String? url;
  final String? title;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: FColorSkin.grey2
        ),
        width: MediaQuery.of(context).size.width*140/486,
        child: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    url ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title ?? '',
                style: FTypoSkin.label3.copyWith(color: ColorScheme.fromSwatch().primary),
              ),
              const SizedBox(height: 8),
              Text(
                '${S.of(context).home_GiaTu} ${ConvertUtils.formatCurrency(price)}đ',
                style: FTypoSkin.label3.copyWith(color: FColorSkin.label),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

}
