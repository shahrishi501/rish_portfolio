import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:rishi_portfolio/widgets/app_icons_screen.dart';
import 'package:rishi_portfolio/widgets/phone_frame.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.95, // 80% of screen height
              child: DeviceFrame(
                device: Devices.ios.iPhone12ProMax,
                isFrameVisible: true,
                orientation: Orientation.portrait,
                
                screen: PortfolioWidget(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }

  
}
