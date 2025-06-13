import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

text(
  data,
  BuildContext context,
) {
  return Text(data,
      style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: 35,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ));
}

Nametext(data, BuildContext context, size) {
  return Text(data,
      style: GoogleFonts.raleway(
        textStyle: Theme.of(context).textTheme.displayMedium,
        fontSize: size,
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
      ));
}

Normaltext(data, BuildContext context, size) {
  return Text(data,
      style: GoogleFonts.raleway(
        textStyle: Theme.of(context).textTheme.displayMedium,
        fontSize: size,
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
      ));
}

extension SizedBoxExtnsion on num {
  SizedBox get widthBox => SizedBox(width: toDouble());
  SizedBox get heightBox => SizedBox(height: toDouble());
}
