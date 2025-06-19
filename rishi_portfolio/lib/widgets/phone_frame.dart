import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 19.5,
        child: Stack(
          children: [
            // Outer metallic border (phone body)
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(52),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 30,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
            ),

            // Side buttons
            // Left Volume Buttons
            Positioned(
              left: -2,
              top: 100,
              child: Column(
                children: [
                  _sideButton(height: 30),
                  SizedBox(height: 12),
                  _sideButton(height: 30),
                ],
              ),
            ),

            // Right Power Button
            Positioned(
              right: -2,
              top: 180,
              child: _sideButton(height: 60),
            ),

            // Main screen inside the border
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  children: [
                    // Dynamic Island
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Content Area
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sideButton({required double height}) {
    return Container(
      width: 6,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
