import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2709/model/user.dart';
import 'package:p2709/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  final List<String> _countries = [
    'Russia',
    'Ukraine',
    'Kazakhstan',
    'Germany',
    'France',
  ];
  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusehange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Text("Register Form"), centerTitle: true),

      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusehange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name *",
                hintText: "What do people call you",
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (value) => _validateName(value!),
              onSaved: (value) => newUser.name = value!,
            ),

            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,

              onFieldSubmitted: (_) {
                _fieldFocusehange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number *",
                hintText: "Where can we reach you?",
                helperText: "Phone format: (XXX)XXX-XXXX",
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    _phoneController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
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
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly
                FilteringTextInputFormatter(
                  RegExp(r'^[()\d-]{1,15}$'),
                  allow: true,
                ),
              ],
              validator: (value) => _validatePhoneNumber(value!)
                  ? null
                  : 'Phone number must be entered as (###)###-#### ',
              onSaved: (value) => newUser.phone = value!,
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
              // validator: (value) => _validateEmail(value!),
              onSaved: (value) => newUser.email = value!,
            ),
            SizedBox(height: 10),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: "Country?",
              ),
              items: _countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country;
                  newUser.country = country!;
                });
              },
              value: _selectedCountry,
              // validator: (val) {
              //   return val == null ? 'Please select a country' : null;
              // },
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
              onSaved: (value) => newUser.story = value!,
            ),

            SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
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
              validator: (value) => _validatePassword(value!),
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
              validator: (value) => _validatePassword(value!),
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
      _formkey.currentState?.save();
      _showDialog(name: _nameController.text);
      print('Form is valid');
      print("Form is valid");
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Counrty: ${_selectedCountry}');
      print('Story: ${_storyController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  String? _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z]+$');
    if (value == null || value.isEmpty) {
      return 'Name is required.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return phoneExp.hasMatch(input);
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email can not be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String value) {
    if (_passController.text.length != 8) {
      return '8 characters required for password';
    } else if (_confirmController.text != _passController.text) {
      return "Passsword does not match";
    } else {
      return null;
    }
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void _showDialog({required String name}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Registration sucessfull",
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            "$name is now verified register form",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(userInfo: newUser),
                  ),
                );
              },
              child: Text(
                "Verified",
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
