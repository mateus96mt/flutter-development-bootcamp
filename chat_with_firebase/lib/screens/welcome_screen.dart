import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Animation colorAnimation;

  @override
  void dispose() {
    super.dispose();
    //remember to dispose animations or they will still be using
    //resources even when screen is not displaying
    _animationController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _animationController.forward();

    _animationController.addListener(() {
      setState(() {});
    });

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
    );

    _animation.addStatusListener((status) {
      if (_animation.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animation.isDismissed) {
        _animationController.forward();
      }
    });

    colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.orange,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(_animationController.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100.0 * _animation.value,
                  ),
                  tag: 'logo',
                ),
                Expanded(
                  child:
                      //     AnimatedTextKit(
                      //   animatedTexts: [
                      //     TypewriterAnimatedText(
                      //       'Flash Chat',
                      //       textStyle: TextStyle(
                      //         fontSize: 45.0,
                      //         fontWeight: FontWeight.w900,
                      //       ),
                      //     ),
                      //   ],
                      // )

                      TypewriterAnimatedTextKit(
                    text: ['Flash Chat'],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${(_animationController.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(colorAnimation: colorAnimation),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.colorAnimation,
  }) : super(key: key);

  final Animation colorAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colorAnimation.value,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.id);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            'Log In',
          ),
        ),
      ),
    );
  }
}
