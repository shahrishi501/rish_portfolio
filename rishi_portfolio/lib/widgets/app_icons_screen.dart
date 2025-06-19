import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioWidget extends StatefulWidget {
  const PortfolioWidget({super.key});

  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {
  Future<void> _launchResume() async {
    final Uri url = Uri.parse(
      'https://drive.google.com/file/d/1HhdpdQRvbId-Ona_j9S8vUWy_FpjsBLH/view?usp=sharing',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchLinkedIn() async {
    final Uri url = Uri.parse('https://www.linkedin.com/in/rishi-shah501/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchGithub() async {
    final Uri url = Uri.parse('https://github.com/shahrishi501');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage("assets/img/IMG_5178.JPG"),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'Rishi Shah',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Software Engineer',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                BoxIcons.bxs_brightness,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                BoxIcons.bxs_contact,

                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Bootstrap.twitter_x,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'X',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            InkWell(
                              onTap: _launchLinkedIn,
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Bootstrap.linkedin,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'LinkedIn',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icons Section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: _launchGithub,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Bootstrap.github,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'GitHub',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                InkWell(
                                  onTap: _launchResume,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      BoxIcons.bx_notepad,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Resume',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showFolderDialog(context, 'Skills', [
                                      _appIcon(Icons.code, 'Flutter'),
                                      _appIcon(Icons.storage, 'Firebase'),
                                      _appIcon(Icons.language, 'API'),
                                      _appIcon(Icons.web, 'HTML'),
                                    ]);
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: _folderBoxDecoration(),
                                    child: _blurredIcon(Icons.person),
                                  ),
                                ),

                                SizedBox(height: 8),
                                Text(
                                  'Skills',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 0.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                    backgroundBlendMode: BlendMode.overlay,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 5,
                                        sigmaY: 5,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Projects',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 30),

                    // About Me Section
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/img/local.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Experience',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 260,
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Message',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Send Message',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFolderDialog(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white24.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 8,
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: items,
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _appIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }

  BoxDecoration _folderBoxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
      backgroundBlendMode: BlendMode.overlay,
    );
  }

  Widget _blurredIcon(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
