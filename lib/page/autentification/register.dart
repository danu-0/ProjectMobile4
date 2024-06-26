import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:Medaran/widget/formR.dart';
import 'login.dart';
import '../../theme/theme.dart';
import '../../widget/buton.dart';
import '../../widget/textbuton.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _username = '';
  String _email = '';
  String _password = '';
  // String? _selectedRole = '';

  // List<String> _roles = ['PELANGGAN', 'ADMIN'];

  Future<void> registerUser() async {
    final url = Uri.parse('https://nest-js-nine.vercel.app/user');
    final Map<String, dynamic> userData = {
      'username': _username,
      'email': _email,
      'password': _password,

      'role': 'PELANGGAN'
      //delete akses admin
      // 'role': _selectedRole,
    };
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          'Register Successful',
          'Login Right Now',
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: primary,
        );
        Get.to(Login());
      } else {
        Get.snackbar(
          'Login Failed',
          '${response.statusCode}',
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: primary,
        );
      }
    } catch (error) {
      print('Failed to register user: $error');
    }
  }

  // void initState() {
  //   super.initState();
  //   _selectedRole = _roles.isNotEmpty ? _roles[0] : null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/textL.png'),
                const Gap(30),
                CustomForm2(
                  desk: 'Username',
                  icon: Icons.person_2_outlined,
                  onChanged: (value) {
                    setState(() {
                      _username = value;
                    });
                  },
                ),
                Gap(30),
                CustomForm2(
                  desk: 'Email',
                  icon: Icons.email_outlined,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                Gap(30),
                CustomForm2P(
                  desk: 'Password',
                  icon: Icons.vpn_key_outlined,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                Gap(30),
                // coment untuk delete akses admin
                // Column(
                //   children: [
                //     DropdownButton<String>(
                //       value: _selectedRole,
                //       icon: Icon(Icons.keyboard_arrow_down),
                //       iconSize: 24,
                //       elevation: 5,
                //       dropdownColor: Colors.white.withOpacity(0.9),
                //       style: TextStyle(
                //         color: primary,
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           _selectedRole = newValue!;
                //         });
                //       },
                //       items:
                //           _roles.map<DropdownMenuItem<String>>((String role) {
                //         return DropdownMenuItem<String>(
                //           value: role,
                //           child: Text(role),
                //         );
                //       }).toList(),
                //     ),
                //   ],
                // ),
                // Gap(30),
                buton(onPressed: registerUser, text: 'Register'),
                Gap(30),
                text2(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    text: 'Sign In',
                    requiredColor: primary),
                Gap(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
