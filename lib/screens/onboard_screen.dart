import 'package:flutter/material.dart';
import 'package:task/screens/home_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  OnBoardScreenState createState() => OnBoardScreenState();
}

class OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  final List<String> images = [
    'assets/onboarding-1.png',
    'assets/onboarding-2.png',
    'assets/onboarding-3.png'
  ];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
              print(currentIndex);
            });
          },
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(images[index]);
          },
        ),
        Positioned(
          bottom: 60,
          child: SizedBox(
            width: 100,
            height: 40,
            child: currentIndex < images.length - 1
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOutSine);
                    },
                    child: const Text('Next'),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text('Continue'),
                  ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                height: 10,
                width: currentIndex == index ? 30 : 10,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
