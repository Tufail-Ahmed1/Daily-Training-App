import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size,Color color,FontWeight fw) {
  return GoogleFonts.poppins(fontSize: size,color: color,fontWeight: fw);
}

TextStyle appStyleWithHt(double size,Color color,FontWeight fw,ht){
  return GoogleFonts.poppins(fontSize: size,color: color,fontWeight: fw,height: ht);
}


