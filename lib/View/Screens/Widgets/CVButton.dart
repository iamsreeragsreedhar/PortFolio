import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cvbutton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  Cvbutton({super.key, required this.text, required this.onPressed});

  @override
  State<Cvbutton> createState() => _CvbuttonState();
}

class _CvbuttonState extends State<Cvbutton> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // return OutlinedButton(
    //     style: OutlinedButton.styleFrom(
    //         side: BorderSide(color: Colors.white, width: 1.5),
    //         foregroundColor: Colors.white,
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
    //     onHover: (value) {},
    //     onPressed: widget.onPressed,
    //     child: Text(widget.text,
    //         style: GoogleFonts.poppins(
    //           textStyle: Theme.of(context).textTheme.titleLarge,
    //           fontSize: 20,
    //           fontWeight: FontWeight.w300,
    //           fontStyle: FontStyle.normal,
    //         )));
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.tealAccent[700],
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
      child: Text(widget.text ,   style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 20,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
            )),
    );
  }
}
