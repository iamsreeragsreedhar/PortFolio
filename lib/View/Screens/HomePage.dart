import 'dart:ui';
import 'dart:html' as html;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:portfoloio_1/Controller/Links.dart';

import 'package:portfoloio_1/View/Screens/Widgets/AnimatedCircle.dart';
import 'package:portfoloio_1/View/Screens/Widgets/CVButton.dart';
import 'package:portfoloio_1/View/Screens/Widgets/Projectcard.dart';
import 'package:portfoloio_1/View/Screens/Widgets/SocialButtons.dart';
import 'package:portfoloio_1/View/Screens/Widgets/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  // Define GlobalKeys for each section
  final GlobalKey section0Key = GlobalKey();

  final GlobalKey section1Key = GlobalKey();

  final GlobalKey section2Key = GlobalKey();

  final GlobalKey section3Key = GlobalKey();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void openResumeWeb() {
    html.window.open('assets/SREERAGCV.pdf', '_blank');
  }

  List<Map<String, dynamic>> appBarList = [];

  List<String> PDAlist = [
    'assets/PDA1.jpeg',
    'assets/PDA2.jpeg',
    'assets/PDA3.jpeg',
  ];

  List<String> FlattrackList = [
    'assets/Flattrack.jpeg',
    'assets/fl2.jpeg',
    'assets/fl3.jpeg'
  ];

  List<String> WMTList = [
    'assets/WMT.jpeg',
    'assets/WMT1.jpeg',
    'assets/WMT2.jpeg',
    'assets/WMT3.jpeg',
  ];

  List<String> tpmwebList = [
    'assets/defaultimage.webp',
    'assets/defaultimage.webp'
  ];

  Future<void> _openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'body': 'I would like to connect with you.'},
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $emailUri');
    }
  }

  Future _launchInBrowserLinkedIn(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    appBarList = [
      {"title": "Home", "key": section0Key},
      {"title": "About Me", "key": section1Key},
      {"title": "Projects", "key": section2Key},
      // {"title": "Contact", "key": section3Key},
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        actions: [
          Texttype.Nametext("<Sreerag>", context, 30),
          700.widthBox,
          for (var item in appBarList)
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextButton(
                onPressed: () => scrollToSection(item["key"]),
                child: Text(
                  item['title'],
                  style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              key: section0Key,
              height: height,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/5424482.JPG',
                      opacity: const AlwaysStoppedAnimation<double>(0.2),
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -80,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(9, 251, 211, 0.4),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: const SizedBox(height: 150, width: 150),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: height * 0.3,
                    right: 20,
                    child: SlideInUp(
                        animate: true,
                        duration: Duration(seconds: 1),
                        child: TextandProfile(context)),
                  ),
                ],
              ),
            ),
            Container(
              key: section1Key,
              height: 650,
              width: double.infinity,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  // Background image with low opacity
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/5424482.JPG',
                      opacity: const AlwaysStoppedAnimation<double>(0.2),
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: -80,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(9, 251, 211, 0.4),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: const SizedBox(height: 150, width: 150),
                      ),
                    ),
                  ),

                  // Main content column
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 90),

                        // Lottie animation + Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Lottie.asset(
                                'About.json',
                                height: 400,
                                width: 400,
                                fit: BoxFit.contain,
                                repeat: true,
                                reverse: true,
                                animate: true,
                              ),
                            ),
                            const SizedBox(width: 40),
                            Flexible(
                              flex: 2,
                              child: Texttype.Paratext(
                                "I am a passionate Flutter developer with over 2 years of experience crafting beautiful, high-performance mobile applications. I specialize in building smooth, responsive, and visually stunning apps that deliver seamless user experiences. My focus is always on clean architecture, modular code, and efficient state management.\n\nFrom idea to deployment, I enjoy owning the full app development lifecycle — designing intuitive UIs, integrating REST APIs or Firebase services, and optimizing for performance and scalability. I’m always eager to explore new technologies and tools that enhance my development workflow, including Bloc, GetX, Provider, and custom animations. \n\nLet’s build something extraordinary together...🚀",
                                context,
                                16,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          spacing: 50,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 30,
                              alignment: WrapAlignment.center,
                              children: [
                                SocialButtons(
                                  Textname: "iamsreeragsreedhar@gmail.com",
                                  onPressed: () async {
                                    await _openEmail();
                                  },
                                  icon: FaIcon(FontAwesomeIcons.envelope),
                                  size: 40,
                                  TipMessage: "Mail Meee 🪂",
                                ),
                                SocialButtons(
                                    Textname:
                                        "www.linkedin.com/in/sreerag-sreedhar-742296229",
                                    onPressed: () async {
                                      // await _launchInBrowserLinkedIn(
                                      //     Linkedinurl);
                                    },
                                    icon: FaIcon(FontAwesomeIcons.linkedin),
                                    size: 40,
                                    TipMessage: "Connect on LinkedIn ❤"),
                                SocialButtons(
                                    Textname:
                                        'https://github.com/iamsreeragsreedhar?tab=repositories',
                                    onPressed: () async {
                                      // await _launchInBrowserLinkedIn(Githuburl);
                                    },
                                    icon: FaIcon(FontAwesomeIcons.github),
                                    size: 40,
                                    TipMessage: "Check Me out in  Github")
                              ],
                            ),
                          ],
                        )

                        // // Skills section
                        // Wrap(
                        //   spacing: 30,
                        //   alignment: WrapAlignment.center,
                        //   children: [
                        //     skillCard('assets/Dart.png', "Dart"),
                        //     skillCard('assets/fltr.png', "Flutter"),
                        //     skillCard('assets/nodejs1.png', "Node.js"),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                key: section2Key,
                height: 650,
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/5424482.JPG',
                        opacity: const AlwaysStoppedAnimation<double>(0.2),
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -80,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(9, 251, 211, 0.4),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                          child: const SizedBox(height: 150, width: 150),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 20,
                        top: height * 0.06,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Projects",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                ProjectCard(
                                  Imagelist: PDAlist,
                                  width: 300,
                                  title: "PDA Application",
                                  description:
                                      "A modern PDA app for real-time warehouse Inbound & Outbound operations.It enhances efficiency by enabling accurate tracking and seamless stock movement.",
                                  imagePath: "assets/PDA1.jpeg",
                                  onTap: () {},
                                ),
                                ProjectCard(
                                  Imagelist: FlattrackList,
                                  width: 300,
                                  title: "Flat Track",
                                  description:
                                      "Flat Track is an online application for managing flat-related activities.It helps streamline housing  operations with easy tracking and reporting.",
                                  imagePath: 'assets/Flattrack.jpeg',
                                  onTap: () {},
                                ),
                                ProjectCard(
                                  Imagelist: WMTList,
                                  width: 300,
                                  title: "Certificate Application",
                                  description:
                                      "Doc Gen Application is developed for generating machinery fitness certificates and inspection reports with role-based access for engineers and supervisors.",
                                  imagePath: 'assets/WMT.jpeg',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Row TextandProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texttype.text("Hi I am Sreerag", context, 30),
              20.heightBox,
              Row(
                children: [
                  AnimatedTextKit(
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flutter Developer',
                        textStyle: GoogleFonts.raleway(
                          fontSize: 32,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      TypewriterAnimatedText(
                        'Mobile Application Developer',
                        textStyle: GoogleFonts.raleway(
                          fontSize: 32,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              20.heightBox,
              Texttype.text(
                "Crafting beautiful, seamless Flutter apps for 2 years turning ideas into smooth experiences.",
                context,
                16,
              ),
              40.heightBox,
              Cvbutton(
                onPressed: () {
                  openResumeWeb();
                },
                text: "DOWNLOAD CV",
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: ClipOval(child: AnimatedProfilePicture()),
        ),
      ],
    );
  }
}
