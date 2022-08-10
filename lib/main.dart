import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF8906),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  dragStartBehavior: DragStartBehavior.down,
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingWidget(
                      image: demoData[index].image,
                      title: demoData[index].title,
                      description: demoData[index].description,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        right: 4,
                      ),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(
                      bottom: 24,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF7f5af0),
                        ),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF7f5af0)
            : const Color(0xFF7f5af0).withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> demoData = [
  OnBoard(
    image: "assets/illustrations/Illustration1.png",
    title: "Find the item you've \nbeen looking for",
    description:
        "Here you'll see rich varities of goods, carefully classified for seamless browsing experience",
  ),
  OnBoard(
    image: "assets/illustrations/Illustration2.png",
    title: "The app that is made \nfor the people",
    description:
        "We have a fantastic team that have invested countless hours to create an app specialized for you",
  ),
  OnBoard(
    image: "assets/illustrations/Illustration3.png",
    title: "The 24x7 support group",
    description:
        "The support team that always listens to your problems before fixing it, always",
  ),
  OnBoard(
    image: "assets/illustrations/Illustration4.png",
    title: "Fast and Secure delivery",
    description:
        "We have partnered with big multinational groups and the items will get delivered to you on time",
  ),
  OnBoard(
    image: "assets/illustrations/Illustration5.png",
    title: "Welcome onboard",
    description:
        "We wish you the best shopping experience that you can ever dream in an app",
  ),
];

class OnboardingWidget extends StatelessWidget {
  final String image, title, description;

  const OnboardingWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.grey),
        ),
        const Spacer(),
      ],
    );
  }
}
