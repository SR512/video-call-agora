import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgetTextTheme {
    static TextTheme lightText = TextTheme(
        headline1: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
        subtitle1: GoogleFonts.poppins(
          color: Colors.black,
        ),
        bodyText1: GoogleFonts.poppins(
          color: Colors.black,
        ),
      button:GoogleFonts.poppins(
        color:const Color(0xFFFFE200)
      )
    );

    static TextTheme darkText = TextTheme(
        headline1: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
        subtitle1: GoogleFonts.poppins(
          color: Colors.white60,
        ),
        bodyText1: GoogleFonts.poppins(
          color: Colors.black,
        ),
        button:GoogleFonts.poppins(
            color:const Color(0xFFFFE200)
        )
    );
}