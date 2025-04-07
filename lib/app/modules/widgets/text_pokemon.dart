import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPokemon extends StatelessWidget {
  const TextPokemon(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.maxLines = 1,
      this.fontWeight});
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
