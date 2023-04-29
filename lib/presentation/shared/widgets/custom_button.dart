import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(
      {super.key,
        required this.label,
        required this.color,
        this.icon,
        this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
        ),
        child: icon != null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kWhiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: kWhiteColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
            : Text(
          label,
          style: GoogleFonts.poppins(
            color: kWhiteColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
