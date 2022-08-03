import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class OrangeButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const OrangeButton({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 14, color: kOffWhite),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
