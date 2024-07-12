import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Service/api_service.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _emailErrorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent.shade100,),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: emailController,
                            validator: (value) => _emailErrorText,
                            onChanged: _validateEmail,
                            decoration: InputDecoration(
                                labelText: 'Your Email.',
                                hintText: "Enter Your Email e.g :Abc@gmai.com",
                                errorText: _emailErrorText,
                                filled: true,
                                fillColor: Colors.deepPurpleAccent.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'Your Password.',
                                filled: true,
                                fillColor: Colors.deepPurpleAccent.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(onPressed: (){
                        Api().login(emailController.text.toString(), passwordController.text.toString());
                      },style:
                      ElevatedButton.styleFrom(backgroundColor:
                      Colors.blue,),
                          child: Text("Login", style: TextStyle( fontSize: 20),)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Email Validation
  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorText = 'Email is required';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorText = 'Enter a valid Email';
      });
    } else {
      setState(() {
        _emailErrorText = null;
      });
    }
  }

  bool isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
