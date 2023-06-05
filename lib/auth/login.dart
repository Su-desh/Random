import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/home_page.dart';
import 'package:random/main.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              //Add form to key to the Form Widget
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Log In",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
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
                    decoration: InputDecoration(
                      hintText: 'Username',
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
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
                      } else if (value.length < 5) {
                        return 'Password length should be more than 4 character';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String emailfromUsername =
                            '${_usernameController.text}@gmail.com';

                        final message = await authService.login(
                          email: emailfromUsername,
                          password: _passwordController.text,
                        );
                        if (message!.contains('Success')) {
                          Get.to(const HomePage());
                        } else {
                          Get.snackbar('error !!', message,
                              backgroundColor: Colors.blue);
                        }
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
