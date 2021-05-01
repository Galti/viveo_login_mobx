import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viveo_login_mobx/constants/animation_durations.dart';
import 'package:viveo_login_mobx/constants/app_colors.dart';
import 'package:viveo_login_mobx/constants/dimens.dart';
import 'package:viveo_login_mobx/stores/form/form_store.dart';
import 'package:viveo_login_mobx/widgets/clip_rectangle.dart';
import 'package:viveo_login_mobx/widgets/login_button.dart';
import 'package:viveo_login_mobx/widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final FormStore store = FormStore();
  bool hasAccount = true;

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    store.setupValidations();

    _animationController = AnimationController(
      duration: Duration(milliseconds: AnimationDurations.mainInMil),
      vsync: this,
    );

    setAnimation();
  }

  @override
  void dispose() {
    store.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.darkBlue,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildLogo(),
                _buildForm(),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() => Column(
        children: [
          Row(children: [Text('BRAND', style: TextStyle(color: Colors.white))]),
          Row(children: [Text('LOGO', style: TextStyle(color: Colors.white))]),
        ],
      );

  Widget _buildForm() => Column(
        children: [
          Observer(
            builder: (_) => LoginTextField(
              hintText: 'Username or email',
              errorText: store.error.username,
              onChanged: store.setUsername,
            ),
          ),
          SizedBox(height: 20),
          Observer(
            builder: (_) => LoginTextField(
              isObscured: true,
              hintText: 'Password',
              errorText: store.error.password,
              onChanged: store.setPassword,
            ),
          ),
          if (!hasAccount) SizedBox(height: 20),
          AnimatedContainer(
            duration: Duration(milliseconds: AnimationDurations.mainInMil),
            height: hasAccount
                ? Dimens.loginElementsHeight
                : Dimens.loginElementsHeight + 40,
            child: hasAccount
                ? null
                : Observer(
                    builder: (_) => LoginTextField(
                      isObscured: true,
                      hintText: 'Repeat password',
                      errorText: store.error.confirmPassword,
                      onChanged: store.setConfirmPassword,
                    ),
                  ),
          ),
        ],
      );

  Widget _buildButtons() => Column(
        children: [
          ClipRectangle(
            child: Container(
              width: double.infinity,
              color: AppColors.darkSecondary,
              child: Stack(
                children: [
                  SlideTransition(
                    position: _animation,
                    child: LayoutBuilder(
                      builder: (_, constraints) => ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: constraints.maxWidth / 2,
                          height: Dimens.loginElementsHeight,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      LoginButton(onPressed: onLoginPress, text: 'Login'),
                      LoginButton(onPressed: onSignUpPress, text: 'Sign-up'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          TextButton(
            child: Text(
              'Forgot password?',
              style: TextStyle(color: AppColors.red),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Not handled.')),
              );
            },
          ),
        ],
      );

  void onLoginPress() {
    if (hasAccount) {
      if (store.validateLogin()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Yay! Logged in!')),
        );
      }
    } else {
      setState(() {
        hasAccount = true;
      });

      _animationController.reverse();
      store.resetValues();
    }
  }

  void onSignUpPress() {
    if (hasAccount) {
      setState(() {
        hasAccount = false;

        _animationController.forward();
        store.resetValues();
      });
    } else {
      if (store.validateSignUp()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Yay! Account created!')),
        );
      }
    }
  }

  void setAnimation() {
    _animation = Tween<Offset>(
      begin: Offset(0, 0.0),
      end: Offset(1, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );
  }
}
