
import 'dart:math';

import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 150,),
            CircularImagePage(),
            SizedBox(height: 150,),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(
                      color: Colors.white, // First part in red
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'Programgrab',
                    style: TextStyle(
                      color: Colors.blueAccent, // Second part in blue
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Feel free to contact us for any query!", style: TextStyle(color: Colors.blueGrey, fontSize: 18), textAlign: TextAlign.center,),
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GoogleSignInButton(),
            ),
            SizedBox(height: 10,),

            Text("or", style: TextStyle(color: Colors.white, fontSize: 22),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SignInButton(),
            ),
            SizedBox(height: 10,),

            Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'By tapping "creating accoun" your are agree to our ',
                    style: TextStyle(
                      color: Colors.blueGrey, // First part in red
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: 'Privicy Policy',
                    style: TextStyle(
                      color: Colors.blueAccent, // Second part in blue
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: Colors.blueGrey, // Second part in blue
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms of Services',
                    style: TextStyle(
                      color: Colors.blueAccent, // Second part in blue
                      fontSize: 18,
                    ),
                  ),
                ],
              ), textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),


          ],
        ),
      ),
    );
  }
}


class CircularImagePage extends StatefulWidget {
  @override
  _CircularImagePageState createState() => _CircularImagePageState();
}
class _CircularImagePageState extends State<CircularImagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(); // Repeat the animation infinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double radius = 120.0; // The radius of the circular path

    return  Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Central static image
          Container(
            width: 120, // Slightly larger to accommodate the glow
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Add BoxShadow for the glow effect
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.1), // Glow color
                  spreadRadius: 80, // How much the glow spreads
                  blurRadius: 50, // How blurry the glow is
                ),
              ],
            ),
            // Clip the image to a circle
            child: ClipOval(
              child: Image.asset(
                'assets/img/landingpagewithneonlight/centerneon.png', // Replace with your central image path
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animated moving images
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(5, (index) {
                  // Calculate the current angle based on the animation value
                  double currentAngle = _controller.value * 2 * pi;
                  double initialAngle = (2 * pi * index) / 5;
                  double totalAngle = initialAngle + currentAngle;

                  // Calculate the x and y positions based on the angle
                  double x = radius * cos(totalAngle);
                  double y = radius * sin(totalAngle);

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Image.asset(
                      'assets/img/landingpagewithneonlight/neon${index + 1}.png', // Replace with your image URL
                      width: 50,
                      height: 50,
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
class SignInButton extends StatefulWidget {
  @override
  _SignInButtonState createState() => _SignInButtonState();
}
class _SignInButtonState extends State<SignInButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    // Add your Google sign-in logic here
    print(' Sign-In Button Pressed');
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Color(0xff0000FF),
            // color: Colors.blue,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.black),

          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text(
                'Create account',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController for neon effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  // Handle tap down to scale the button
  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  // Handle tap up to scale back and execute sign-in logic
  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    // Add your Google sign-in logic here
    print('Google Sign-In Button Pressed');
  }

  // Handle tap cancel to reset the button state
  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            child: Container(
              // Neon Gradient and Glow
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: SweepGradient(
                  colors: [
                    Color(0xff0000FF),
                    Colors.white,
                    Color(0xff0000FF),
                    // Colors.white,
                    // Colors.blueAccent,
                  ],
                  stops: [0.0,  0.5, 1.0],
                  transform: GradientRotation(_controller.value * 4 * pi),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.6),
                    spreadRadius: 4,
                    blurRadius: 20,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3), // Border width for neon effect
              child: Container(
                // Actual Button Design
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black, // Button background color
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blueAccent.shade100),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Logo
                    Image.asset(
                      'assets/img/landingpagewithneonlight/Google.png',
                      height: 24.0,
                    ),
                    SizedBox(width: 12.0),
                    // Button Text
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}