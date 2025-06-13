import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final imagePath;
  final double width;
  final List<String> Imagelist;
  final VoidCallback onTap;

  ProjectCard({
    required this.title,
    required this.description,
    this.imagePath,
    required this.onTap,
    super.key,
    required this.width,
    this.Imagelist = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(
            255, 255, 255, 0.05), // translucent glass style
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: (Imagelist.isEmpty)
                ? Image.asset(
                    (imagePath == '' || imagePath == null)
                        ? 'assets/defaultimage.webp'
                        : imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : FanCarouselImageSlider.sliderType1(
                    isClickable: true,
                    imageFitMode: BoxFit.contain,
                    sliderHeight: 300,
                    imagesLink: Imagelist,
                    currentItemShadow: const [],
                    sliderDuration: const Duration(milliseconds: 200),
                    imageRadius: 0,
                    slideViewportFraction: 1.2,
                    isAssets: true,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "View Github",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
