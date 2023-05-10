import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:login_reg_demo/core/theme.dart';
import 'package:login_reg_demo/service/snackbar_service.dart';

import '../../shared/appbar.dart';
import '../../shared/exit_check.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return ExitCheck(
      Scaffold(
        appBar: buildAppBar(title: 'Sign Up'),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formGlobalKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return '* Enter mail id';
              } else if (name.length < 3) {
                return "It must be atleast 3 characters in length";
              } else if (name.contains(RegExp(r'(\d+)'))) {
                return "* Must not contain digit";
              } else if (name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return "* Must not contain special characters";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            controller: nameController,
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return '* Enter a valid email address';
              } else if (!email.contains('@gmail.com')) {
                return '* Must be a valid gmail address';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            controller: emailController,
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(labelText: 'DOB'),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                _dateController.text = DateFormat.yMMMMd().format(pickedDate);
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Enter Password'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) {
              if (password!.length < 5) {
                return "* It must be atleast 6 characters in length";
              } else {
                return null;
              }
            },
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: passwordController,
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
          ),
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            validator: (password) {
              if (password != passwordController.text) {
                return '* Password did not match';
              } else {
                return null;
              }
            },
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: confirmPasswordController,
            inputFormatters: [LengthLimitingTextInputFormatter(20)],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_formGlobalKey.currentState!.validate()) {
                // post register request here

                if (true) {
                  // ignore: use_build_context_synchronously
                  buildSignUpOtpVerify(
                    context,
                    height: height,
                    otpController: otpController,
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    dob: _dateController,
                  );
                }
              }
            },
            child: const Text('Sign Up'),
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already registered?'),
              GestureDetector(
                onTap: (() => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)),
                child: const Text(
                  ' Sign In',
                  style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

buildSignUpOtpVerify(
  BuildContext context, {
  required double height,
  required TextEditingController otpController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController nameController,
  required TextEditingController dob,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    builder: (builder) {
      return ExitCheck(
        Container(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "To verify your email we have sent code to your email,\n Please enter code into the OTP box",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Enter otp'),
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return '* Enter otp';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    controller: otpController,
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      buildShowSnackBarService(context, msz: 'Hi ${nameController.text.toUpperCase()}!!!');
                      // post signup otp verify here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExitCheck(Scaffold(
                            appBar: buildAppBar(title: 'Dashboard'),
                            body: const Center(child: Text('Dashboard')),
                          )),
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
