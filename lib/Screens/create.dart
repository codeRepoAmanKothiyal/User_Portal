import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Service/api_service.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  String? _nameErrorText ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create"),),
      body: Center(
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
                          controller: jobController,
                          decoration: InputDecoration(
                              labelText: 'Your job.',
                              hintText: "Enter Your job",
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
                      Api().create(nameController.text.toString(), jobController.text.toString());
                    },style:
                    ElevatedButton.styleFrom(backgroundColor:
                    Colors.green,),
                        child: Text("Create", style: TextStyle( fontSize: 20),)),
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

}
