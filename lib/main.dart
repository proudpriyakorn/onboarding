import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/1.png",
      "title": "Birth Day. Anywhere. Anytime.",
      "desc":  "We bake and deliver fresh cakes and desserts straight from our kitchen to your doorstep knock knock!"
    },
    {
      "image": "assets/images/2.png",
      "title": "Simple & Easy to use",
      "desc":  "Browse our menu, pick your favorite cake, and place your order in just a few taps."
    },
    {
      "image": "assets/images/3.png",
      "title": "Surprise your loved ones ",
      "desc":  "Need something custom? Chat with us directly and we’ll make the perfect cake for your special person, special day."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
              // 🔹 Header topic (Left aligned)
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Left side: !s0s!
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, 6),
            child: const Text(
              "!",
              style: TextStyle(
                color: Color(0xFFE45854),
                fontSize: 78,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Transform.translate(
            offset: const Offset(0, -6),
            child: const Text(
              "s",
              style: TextStyle(
                color: Color(0xFFE45854),
                fontWeight: FontWeight.bold,
                fontSize: 58,

              ),
            ),
          ),
          const SizedBox(width: 12),
          Transform.translate(
            offset: const Offset(0, -12),
            child: const Text(
              "0",
              style: TextStyle(
                color: Color(0xFFE45854),
                fontSize: 58,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Transform.translate(
            offset: const Offset(0, -6),
            child: const Text(
              "s",
              style: TextStyle(
                color: Color(0xFFE45854),
                fontSize: 58,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Transform.translate(
            offset: const Offset(0, 6),
            child: const Text(
              "!",
              style: TextStyle(
                color: Color(0xFFE45854),
                fontSize: 78,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      // Right side: Cake below sos
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          SizedBox(height: 100), // pushes Cake lower
          Text(
            "Cake",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 49, 28, 4),
              letterSpacing: 5.0,
            ),
          ),
        ],
      ),
    ],
  ),
),


            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            onboardingData[index]['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboardingData[index]['title']!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          onboardingData[index]['desc']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: _currentIndex == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.white : Colors.white38,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Navigation buttons (Back, Skip, Next, Get Started)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (hidden on first page)
                  (_currentIndex > 0)
                      ? TextButton(
                          onPressed: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            "← Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox(width: 60),

                  // Skip button (hidden on last page)
                  (_currentIndex < onboardingData.length - 1)
                      ? TextButton(
                          onPressed: () {
                            _controller.jumpToPage(onboardingData.length - 1);
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox(width: 60),

                  // Next / Get Started button
                  (_currentIndex == onboardingData.length - 1)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: const Color.fromARGB(255, 151, 198, 221),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          onPressed: () {
                            // Navigate to home
                          },
                          child: const Text("Get SURPRISED!"),
                        )
                      : TextButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            "Next →",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 151, 198, 221), // green background
    );
  }
}
