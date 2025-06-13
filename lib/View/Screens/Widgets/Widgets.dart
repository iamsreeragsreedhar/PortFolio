import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Texttype {
  static text(data, BuildContext context, size) {
    return Text(data,
        style: GoogleFonts.ptSerif(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontSize: size,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ));
  }

  static Paratext(data, BuildContext context, size) {
    return Text(data,
        style: GoogleFonts.jost(
          textStyle: Theme.of(context).textTheme.bodySmall,
          fontSize: size,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
        ));
  }

  static Nametext(data, BuildContext context, size) {
    return Text(data,
        style: GoogleFonts.hurricane(
          textStyle: Theme.of(context).textTheme.displayMedium,
          fontSize: size,
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.normal,
        ));
  }

  static Normaltext(data, BuildContext context, size) {
    return Text(data,
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.labelMedium,
          fontSize: size,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
        ));
  }

  static Headingtext(data, BuildContext context, size) {
    return Text(data,
        style: GoogleFonts.breeSerif(
          textStyle: Theme.of(context).textTheme.labelMedium,
          fontSize: size,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
        ));
  }
}

extension SizedBoxExtnsion on num {
  SizedBox get widthBox => SizedBox(width: toDouble());
  SizedBox get heightBox => SizedBox(height: toDouble());
}

Widget skillCard(String imagePath, String skillName) {
  return Tooltip(
    message: skillName,
    child: Container(
      height: 60,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
    ),
  );
}
