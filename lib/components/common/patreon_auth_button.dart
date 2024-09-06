import 'package:flutter/material.dart';

import '../../helpers/colour_helper.dart';
import './donation_image.dart';

class PatreonAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PatreonAuthButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        backgroundColor: WidgetStateProperty.all(HexColor('FF424D')),
        side: WidgetStateProperty.all(
          const BorderSide(
            width: 2.0,
            color: Colors.transparent,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        shadowColor: WidgetStateProperty.all(Colors.black),
        overlayColor: WidgetStateProperty.all(HexColor('D13A40')),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DonationImage.patreon(useAlt: true),
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Login with Patreon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.50,
            ),
          ),
        ],
      ),
    );
  }
}
