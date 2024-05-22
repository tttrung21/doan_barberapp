import 'package:flutter/material.dart';


class AccountNameSection extends StatelessWidget {
  const AccountNameSection({
    super.key,
    this.currentName,
  });

  final String? currentName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: USER NAME
          Text(
            currentName ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF7D5A50),
            ),
          ),
        ],
      ),
    );
  }
}
