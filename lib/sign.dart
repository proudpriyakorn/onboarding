import 'package:flutter/material.dart';
import 'dart:async';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with TickerProviderStateMixin {
  bool isSignIn = true;

  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Logo bounce controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _logoAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Text jump controller
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: -12.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    // Repeat animations every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _logoController.forward().then((_) => _logoController.reverse());
      _textController.forward().then((_) => _textController.reverse());
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 242, 63),
              Color.fromARGB(255, 255, 250, 150),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header with Snapchat Logo
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: _logoAnimation,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomPaint(
                              size: const Size(60, 60),
                              painter: SnapchatLogoPainter(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _textAnimation.value),
                            child: child,
                          );
                        },
                        child: const Text(
                          "Welcome to Snapchat!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Auth Container
                Container(
                  width: 380,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Toggle
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isSignIn = true),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: isSignIn
                                        ? const Color.fromARGB(
                                            255, 255, 242, 63)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: isSignIn
                                            ? Colors.black
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isSignIn = false),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: !isSignIn
                                        ? const Color.fromARGB(
                                            255, 255, 242, 63)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: !isSignIn
                                            ? Colors.black
                                            : Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: isSignIn ? _SignInForm() : _SignUpForm(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "© 2024 Snapchat. All rights reserved.",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ✅ Updated Sign In Form with Forgot Password right under Sign In
class _SignInForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _continueWithEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Continue with Email - Quick sign-in coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _continueWithApple(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Continue with Apple - Feature coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _signIn(BuildContext context) {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // ✅ Go to onboarding instead of home
      Navigator.pushReplacementNamed(context, '/onboarding');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email Address",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 242, 63),
            foregroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: const Size(double.infinity, 48),
          ),
          onPressed: () => _signIn(context),
          child: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // 👇 Forgot Password right under Sign In
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Forgot password feature coming soon!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "or continue with",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300])),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 242, 63),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 48),
            elevation: 0,
          ),
          onPressed: () => _continueWithEmail(context),
          icon: const Icon(Icons.email_outlined, size: 20),
          label: const Text(
            "Continue with Email",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 48),
            elevation: 0,
          ),
          onPressed: () => _continueWithApple(context),
          icon: const Icon(Icons.apple, size: 20),
          label: const Text(
            "Continue with Apple",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ✅ Sign Up Form (unchanged from your version)
class _SignUpForm extends StatefulWidget {
  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  DateTime? _selectedBirthdate;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectBirthdate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 255, 242, 63),
              onPrimary: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedBirthdate) {
      setState(() {
        _selectedBirthdate = picked;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

    void _createAccount() {
    if (_formKey.currentState!.validate()) {
      if (_selectedBirthdate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your birthdate'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // ✅ Go to onboarding instead of home
      Navigator.pushReplacementNamed(context, '/onboarding');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome ${_firstNameController.text}!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: "First Name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) => _validateName(value, 'First name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: "Last Name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) => _validateName(value, 'Last name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email Address",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _selectBirthdate,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[100],
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey[600]),
                  const SizedBox(width: 12),
                  Text(
                    _selectedBirthdate == null
                        ? 'Select Birthdate'
                        : '${_selectedBirthdate!.day}/${_selectedBirthdate!.month}/${_selectedBirthdate!.year}',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedBirthdate == null
                          ? Colors.grey[600]
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: _validatePassword,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: _validateConfirmPassword,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 242, 63),
              foregroundColor: Colors.black,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: _createAccount,
            child: const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// ✅ Snapchat Logo Painter
class SnapchatLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFF963)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final path = Path();
    final shadowPath = Path();

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final logoSize = size.width * 0.8;

    for (var currentPath in [shadowPath, path]) {
      final offsetX = currentPath == shadowPath ? 1.5 : 0.0;
      final offsetY = currentPath == shadowPath ? 1.5 : 0.0;

      currentPath.moveTo(centerX + offsetX, centerY - logoSize * 0.4 + offsetY);
      currentPath.quadraticBezierTo(
        centerX - logoSize * 0.35 + offsetX,
        centerY - logoSize * 0.4 + offsetY,
        centerX - logoSize * 0.35 + offsetX,
        centerY - logoSize * 0.1 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX - logoSize * 0.35 + offsetX,
        centerY + logoSize * 0.2 + offsetY,
        centerX - logoSize * 0.25 + offsetX,
        centerY + logoSize * 0.35 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX - logoSize * 0.15 + offsetX,
        centerY + logoSize * 0.45 + offsetY,
        centerX - logoSize * 0.05 + offsetX,
        centerY + logoSize * 0.35 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX + logoSize * 0.05 + offsetX,
        centerY + logoSize * 0.25 + offsetY,
        centerX + logoSize * 0.15 + offsetX,
        centerY + logoSize * 0.35 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX + logoSize * 0.25 + offsetX,
        centerY + logoSize * 0.45 + offsetY,
        centerX + logoSize * 0.35 + offsetX,
        centerY + logoSize * 0.35 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX + logoSize * 0.35 + offsetX,
        centerY + logoSize * 0.2 + offsetY,
        centerX + logoSize * 0.35 + offsetX,
        centerY - logoSize * 0.1 + offsetY,
      );
      currentPath.quadraticBezierTo(
        centerX + logoSize * 0.35 + offsetX,
        centerY - logoSize * 0.4 + offsetY,
        centerX + offsetX,
        centerY - logoSize * 0.4 + offsetY,
      );

      currentPath.close();
    }

    canvas.drawPath(shadowPath, shadowPaint);
    canvas.drawPath(path, paint);

    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(centerX - logoSize * 0.12, centerY - logoSize * 0.12),
      logoSize * 0.055,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(centerX - logoSize * 0.12, centerY - logoSize * 0.12),
      logoSize * 0.03,
      pupilPaint,
    );

    canvas.drawCircle(
      Offset(centerX + logoSize * 0.12, centerY - logoSize * 0.12),
      logoSize * 0.055,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(centerX + logoSize * 0.12, centerY - logoSize * 0.12),
      logoSize * 0.03,
      pupilPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

