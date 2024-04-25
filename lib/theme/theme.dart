import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

//assets colour
Color white = const Color(0xFFFFFFFF);
Color primarytext = const Color(0xFF31322F);
Color secondarytext = const Color(0xFF959894);
Color primary = const Color(0xFF003C43);
Color scaffoldBg = const Color(0xFFF9FFF2);
Color secondary = const Color(0xFF77B0AA);
Color icon = const Color(0xFF9BCF53);
Color selected = const Color(0xFFEEB700);
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

//assets padding
const double appPadding = 20.0;

//assets text
// TextStyle BoldText = GoogleFonts.poppins(
//   color: primarytext,
//   fontSize: 20,
//   fontWeight: extraBold,
// );
// TextStyle MediumText =
//     GoogleFonts.poppins(color: primarytext, fontSize: 16, fontWeight: medium);
// TextStyle NameProduct =
//     GoogleFonts.poppins(color: primarytext, fontSize: 14, fontWeight: bold);
// TextStyle RegulerText =
//     GoogleFonts.poppins(color: primarytext, fontSize: 14, fontWeight: regular);
// TextStyle secondText = GoogleFonts.poppins(
//     color: secondarytext, fontSize: 14, fontWeight: regular);

// Asset untuk gradient
final Gradient darkBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primarytext,
  ],
);
