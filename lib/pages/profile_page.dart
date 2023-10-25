import 'package:flutter/material.dart';
import 'package:authify/animations/custom_animation.dart';
import 'package:authify/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late Color _primaryColor;
  late double _deviceWidth;
  late double _deviceHeight;
  late AnimationController _animController;
  late CustomAnimation _customAnimation;

  @override
  void initState() {
    super.initState();
    _primaryColor = const Color.fromRGBO(169, 224, 241, 1.0);
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _deviceWidth,
            height: _deviceHeight * 0.60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _avatarImage(),
                SizedBox(height: _deviceHeight * 0.03),
                _nameText(),
                SizedBox(height: _deviceHeight * 0.20),
                _logoutButton(),
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
              color: _primaryColor,
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

  Widget _nameText() {
    return Text(
      'John Doe',
      style: TextStyle(
        color: _primaryColor,
        fontSize: 35.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _logoutButton() {
    return MaterialButton(
      onPressed: _logout,
      color: Colors.white,
      minWidth: _deviceWidth * 0.38,
      height: _deviceHeight * 0.055,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(color: _primaryColor, width: 3.0),
      ),
      child: Text(
        'LOG OUT',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: _primaryColor,
        ),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => const LoginPage(),
      ),
    );
  }
}
