import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
final Color color;
  const CustomButton({super.key, required this.label,required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextButton(
        onPressed: () {},
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


class InfoRow extends StatelessWidget {
  final String label;
  final String textButton;
  final Color colorLabel;
  final Color colorTextButton;
  const InfoRow({Key? key, required this.label, required this.textButton, required this.colorLabel, required this.colorTextButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: 18,
            color: colorLabel,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: kWhiteColor,
          ),
          child: Text(
            textButton,
            style:  TextStyle(
              color: colorTextButton,
            ),
          ),
        ),
      ],
    );
  }
}
