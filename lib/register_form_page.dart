import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Form"), centerTitle: true),

      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name *",
                hintText: "What do people call you",
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(Icons.delete_outline, color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Name is required' : null,
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number *",
                hintText: "Where can we reach you?",
                helperText: "Phone format: (XXX)XXX-XXXX",
                prefixIcon: Icon(Icons.call),
                suffixIcon: Icon(Icons.delete_outline, color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email Address *",
                hintText: "Enter a email address",
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: "Life Story",
                hintText: "Tell us about your self",
                helperText: "Keep it short, it's just a demo",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Password *",
                hintText: "Enter the password",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: Icon(
                    _hidePass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                icon: Icon(Icons.security),
              ),
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: _confirmController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Confirm Password *",
                hintText: "Confirm the password",
                icon: Icon(Icons.border_color),
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Submit Form", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formkey.currentState!.validate()) {
      print("Form is valid");
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Story: ${_storyController.text}');
    }
  }
}
