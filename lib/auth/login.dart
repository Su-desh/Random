import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/API/api.dart';
import 'package:random/auth/auth.dart';
import 'package:random/home_page.dart';

import '../helper/dialogs.dart';

/// Log in Screen page for the existing user
class LogInScreen extends StatefulWidget {
  // ignore: public_member_api_docs
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPressedlogin = false;

  // show or hide password
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

//first letter is number
  bool checkFirstLetterIsNotNum(String nam) {
    bool isFirstLetterNum = false;
    List<String> numList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String firstletter = nam[0];

    for (String i in numList) {
      if (firstletter == i) {
        isFirstLetterNum = true;
        break;
      }
    }
    return isFirstLetterNum;
  }

// called when log in button is pressed
  Future<void> _loginValidate() async {
    if (_formKey.currentState!.validate()) {
      //the button is pressed
      setState(() {
        isPressedlogin = true;
      });
      String emailfromUsername = '${_usernameController.text}@gmail.com';

      final message = await AuthService.login(
        email: emailfromUsername,
        password: _passwordController.text,
      );
      if (message!.contains('Success')) {
        // update status
        await APIs.updateActiveStatus(true);
        Get.to(const HomePage());
      } else {
        //error occured
        setState(() {
          isPressedlogin = false;
        });
        Dialogs.showGetSnackbar(
          'error !!',
          message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                //Add form to key to the Form Widget
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.message,
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Log In",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //Assign controller
                      controller: _usernameController,
                      validator: (value) {
                        //if the username is null or empty
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Username';
                        }
                        //if the username lenght is < 5
                        else if (value.length < 5) {
                          return 'Username length should be more than 4 character';
                        }
                        //if the first letter is number
                        else if (checkFirstLetterIsNotNum(value)) {
                          return 'first letter can not be number';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        focusColor: Colors.black,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      //Assign controller
                      controller: _passwordController,
                      obscureText: _obscured,
                      focusNode: textFieldFocusNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        } else if (value.length < 6) {
                          return 'Password length should be more than 5 character';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: _toggleObscured,
                          child: Icon(
                            _obscured
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    !isPressedlogin
                        ? SizedBox(
                            height: 50,
                            width: Get.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              onPressed: _loginValidate,
                              child: const Text(
                                'Log In',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 50,
                            width: Get.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Please wait..",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have Account?",
                              style: TextStyle(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                "  SignIn",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
