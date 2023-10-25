import 'package:flutter/material.dart';
import 'package:authify/animations/custom_animation.dart';
import 'package:authify/pages/profile_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late Color _primaryColor;
  late Color _secondaryColor;
  late double _deviceWidth;
  late double _deviceHeight;
  late AnimationController _animController;
  late CustomAnimation _customAnimation;

  @override
  void initState() {
    super.initState();
    _primaryColor = const Color.fromRGBO(125, 191, 211, 1.0);
    _secondaryColor = const Color.fromRGBO(169, 224, 241, 1.0);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _customAnimation = CustomAnimation(_animController);
    _animController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _primaryColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _deviceWidth,
            height: _deviceHeight * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _avatarImage(),
                SizedBox(height: _deviceHeight * 0.05),
                _emailField(),
                _passwordField(),
                SizedBox(height: _deviceHeight * 0.10),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarImage() {
    double diameter = _deviceHeight * 0.25;
    return AnimatedBuilder(
      animation: _customAnimation.controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _customAnimation.circleSize.value,
            _customAnimation.circleSize.value,
            1,
          ),
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.circular(500.0),
              image: const DecorationImage(
                image: AssetImage('assets/main_avatar.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: const TextField(
        cursorColor: Colors.white,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Email@example.com',
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return SizedBox(
      width: _deviceWidth * 0.70,
      child: const TextField(
        cursorColor: Colors.white,
        obscureText: true,
        obscuringCharacter: '*',
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _login,
      color: Colors.white,
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: const BorderSide(color: Colors.white),
      ),
      child: Text(
        'LOG IN',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: _primaryColor,
        ),
      ),
    );
  }

  Future<void> _login() async {
    await _animController.reverse();
    await Future.delayed(const Duration(), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          pageBuilder: (_, __, ___) => const ProfilePage(),
        ),
      );
    });
  }
}
