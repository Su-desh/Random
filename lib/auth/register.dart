import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random/auth/login.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _registerGlobalFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();

  handleSubmit() async {
    if (!_registerGlobalFormKey.currentState!.validate()) return;
    // final userName = _userNameController.value.text;

    // auth.
    // auth.registerTheNewUser(userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                //Assign controller
                controller: _userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Valid Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Username',
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, foregroundColor: Colors.white),
            // onPressed: null,
            onPressed: () {},
            child: const Text('Continue'),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(const LogInScreen());
              },
              child: const Text(
                'Already have an Account ?',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
