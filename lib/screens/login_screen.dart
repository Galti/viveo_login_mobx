import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viveo_login_mobx/constants/app_colors.dart';
import 'package:viveo_login_mobx/stores/form/form_store.dart';
import 'package:viveo_login_mobx/widgets/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FormStore store = FormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
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
          Row(children: [
            Text(
              'BRAND',
              style: TextStyle(color: Colors.white),
            )
          ]),
          Row(children: [
            Text(
              'LOGO',
              style: TextStyle(color: Colors.white),
            )
          ]),
        ],
      );

  Widget _buildForm() => Column(
        children: [
          Observer(
            builder: (_) => LoginTextField(onChanged: store.setUsername, hintText: 'Username or email', errorText: store.error.username),
          ),
          SizedBox(height: 20),
          Observer(
            builder: (_) => LoginTextField(onChanged: store.setPassword, hintText: 'Password', errorText: store.error.password),
          ),
          SizedBox(height: 20),
        ],
      );

  Widget _buildButtons() => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: double.infinity,
              color: Color.fromRGBO(32, 52, 69, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text('Login', style: TextStyle(color: Colors.white)),
                      onPressed: store.validateAll,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text('Sign-up', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
          TextButton(
            child: Text('Forgot password?', style: TextStyle(color: Colors.white)),
            onPressed: () {},
          ),
        ],
      );
}
