import 'package:flutter/material.dart';
import 'package:login_reg_demo/core/theme.dart';
import 'package:login_reg_demo/shared/exit_check.dart';

import '../../service/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return ExitCheck(
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Login Page'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
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

                        // Show a success snackbar or navigate to the next screen
                        buildShowSnackBarService(context, msz: 'Login successful');
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
