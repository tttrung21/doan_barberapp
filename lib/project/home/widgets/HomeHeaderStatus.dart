import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../components/skin/typo_skin.dart';
import '../../../generated/l10n.dart';

class HomeHeaderStatus extends StatefulWidget {
  const HomeHeaderStatus({super.key});

  @override
  State<HomeHeaderStatus> createState() => _HomeHeaderStatusState();
}

class _HomeHeaderStatusState extends State<HomeHeaderStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      width: MediaQuery.of(context).size.width*0.6,
      decoration: BoxDecoration(
        color: const Color(0xFF979797).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 30,
        child: AnimatedTextKitBarberShopStatus(),
      ),
    );
  }
}

class AnimatedTextKitBarberShopStatus extends StatelessWidget {
  AnimatedTextKitBarberShopStatus({
    super.key,
  });

  final now = DateTime.now();

  bool isOpen(DateTime time){
    if(now.hour >= 9 && now.hour < 17) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          isOpen(now) ? S.of(context).shop_opened : S.of(context).shop_closed,
          textStyle: FTypoSkin.title1,
          textAlign: TextAlign.center,
        ),
      ],
      pause: const Duration(milliseconds: 500),
      repeatForever: true,
    );
  }
}

