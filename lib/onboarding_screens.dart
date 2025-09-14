import 'package:flutter/material.dart';
import 'main.dart';

final List<Map<String, String>> onboardingData = [
  {
    "title": "Welcome to Netflix",
    "description":
        "Stream movies, TV shows, and exclusive originals anytime, anywhere.",
    "image": "assets/images/14.png",
  },
  {
    "title": "Discover Unlimited Content",
    "description": "Explore genres, shows, and movies tailored just for you.",
    "image": "assets/images/15.png",
    "background": "assets/images/13.jpg",
  },
  {
    "title": "Watch Anywhere",
    "description":
        "Enjoy streaming on your phone, tablet, or TV with one account.",
    "image": "assets/images/17.png",
    "background": "assets/images/18.png",
  },
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return OnboardingPage(
                  title: data['title']!,
                  description: data['description']!,
                  image: data['image']!,
                  backgroundImage: data['background'],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (_currentIndex < onboardingData.length - 1)
                      ? TextButton(
                          onPressed: goToHome,
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox(width: 60),
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 10,
                        width: _currentIndex == index ? 22 : 10,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.red
                              : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  (_currentIndex == onboardingData.length - 1)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: goToHome,
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            if (_currentIndex > 0)
                              IconButton(
                                onPressed: () {
                                  _controller.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.purple),
                              )
                            else
                              const SizedBox(width: 40),
                            IconButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward,
                                  color: Colors.purple),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String? backgroundImage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (backgroundImage != null)
          Image.asset(
            backgroundImage!,
            fit: BoxFit.cover,
          ),
        if (backgroundImage != null)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 500,
                width: image == "assets/images/17.png" ? 350 : 400,
              ),
              const SizedBox(height: 30),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[300],
                  height: 1.4,
                  shadows: const [Shadow(blurRadius: 8, color: Colors.black45)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
