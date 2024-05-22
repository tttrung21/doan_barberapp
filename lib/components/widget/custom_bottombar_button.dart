import 'package:doan_barberapp/components/skin/color_skin.dart';
import 'package:flutter/material.dart';

class CustomBottomBarButton extends StatelessWidget {
  const CustomBottomBarButton({
    super.key,
    required this.text,
    required this.press,
  });

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50/896 * MediaQuery.of(context).size.height,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => FColorSkin.primary),
        ),
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
