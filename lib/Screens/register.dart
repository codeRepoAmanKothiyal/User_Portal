import 'package:flutter/material.dart';
import 'package:user_portal/Service/api_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _nameErrorText ;
  String? _emailErrorText;
  String? _passWordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text("Register")),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent.shade100,),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          validator: (value) => _nameErrorText,
                          onChanged: _validateName,
                          decoration: InputDecoration(
                              labelText: 'Your Name.',
                              hintText: "Enter Your Name e.g :Aman",
                              errorText: _nameErrorText,
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
                          validator: (value) => _passWordErrorText,
                          onChanged: _validatePassword,
                          decoration: InputDecoration(
                              labelText: 'Your Password.',
                              errorText: _passWordErrorText,
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
                      Api().register(emailController.text.toString(), passwordController.text.toString());
                    },style:
                    ElevatedButton.styleFrom(backgroundColor:
                    Colors.green,),
                        child: Text("Register", style: TextStyle( fontSize: 20),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Name Validation
  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() {
        _nameErrorText = 'Name is required';
      });
    } else if (!isNameValid(value)) {
      setState(() {
        _nameErrorText = 'Enter a valid name';
      });
    } else {
      setState(() {
        _nameErrorText = null;
      });
    }
  }

  bool isNameValid(String name) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(name);
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

  // Email Validation
  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passWordErrorText = 'Password is required';
      });
    } else if (!isPasswordValid(value)) {
      setState(() {
        _passWordErrorText = 'Enter a valid Password';
      });
    } else {
      setState(() {
        _passWordErrorText = null;
      });
    }
  }
  bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
  }
}
