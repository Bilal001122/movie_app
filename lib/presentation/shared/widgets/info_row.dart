import 'package:flutter/material.dart';
import 'package:movie_app/const/colors.dart';
import 'package:movie_app/logic/models/movie.dart';

class InfoRow extends StatelessWidget {
  final List<MovieModel> movies;
  final String label;
  final String textButton;
  final Color colorLabel;
  final Color colorTextButton;
  final String textLabelCategorie;

  const InfoRow({
    Key? key,
    required this.label,
    required this.textButton,
    required this.colorLabel,
    required this.colorTextButton,
    required this.movies,
    required this.textLabelCategorie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: colorLabel,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/see_more', arguments: {
              'movies': movies,
              'textLabelCategorie': textLabelCategorie,
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: kWhiteColor,
          ),
          child: Text(
            textButton,
            style: TextStyle(
              color: colorTextButton,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
