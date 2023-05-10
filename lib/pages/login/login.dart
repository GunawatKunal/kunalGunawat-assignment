import 'package:flutter/material.dart';
import 'package:login_reg_demo/core/theme.dart';
import 'package:login_reg_demo/shared/exit_check.dart';

import '../../service/snackbar_service.dart';
import '../../shared/appbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ExitCheck(
      Scaffold(
        appBar: buildAppBar(title: 'Login'),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(hintText: 'Your Email'),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return '* Enter a valid email address';
              } else if (!email.contains('@gmail.com')) {
                return '* Must be a valid gmail address';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
              suffixIcon: InkWell(
                onTap: () => setState(() {
                  obscureText = !obscureText;
                }),
                child: Icon(
                  obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  color: AppColor.secondaryColor,
                ),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText,
            keyboardType: TextInputType.text,
            controller: _passwordController,
            validator: (password) {
              if (password!.isEmpty) {
                return "* Kindly enter password";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                // Form is valid, perform login logic here
                String username = _emailController.text;
                String password = _passwordController.text;

                // Perform login operation with the entered username and password
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExitCheck(Scaffold(
                      appBar: buildAppBar(title: 'Dashboard'),
                      body: const Center(child: Text('Dashboard')),
                    )),
                  ),
                );
                // Show a success snackbar or navigate to the next screen
                buildShowSnackBarService(context, msz: 'Login successful');
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Not Registered?'),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false),
                child: const Text(
                  ' Create Account',
                  style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
