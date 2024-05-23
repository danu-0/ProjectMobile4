import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tester/page/addMedia.dart';
import 'package:tester/page/home.dart';
import '../controller/controller.dart';
import '../theme/theme.dart';
import '../widget/buton.dart';
import '../widget/form.dart';
import 'package:gap/gap.dart';
import '../widget/textbuton.dart';
import '../page/register.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:3000/login');
    final username = _usernameController.text;
    final password = _passwordController.text;
    final UserController userController = Get.put(UserController());

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        await Future.delayed(Duration(seconds: 1));
        userController.setUser(responseData);
        Get.off(Home());
        Get.snackbar(
          'Login Successful',
          'Welcome, ${responseData['username']}!',
          backgroundColor: Colors.white.withOpacity(0.5),
          colorText: primary,
        );
      } else {
        final responseData = jsonDecode(response.body);
        print(responseData);
        final errorMessage = responseData['message'] ?? 'Login failed';
        Get.snackbar('Login Failed', errorMessage);
      }
    } catch (error) {
      print('Failed to login: $error');
      Get.snackbar('Error', 'Failed to login. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
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
                const Gap(60),
                CustomForm(
                  desk: 'Username',
                  icon: Icons.account_circle_outlined,
                  controller: _usernameController,
                ),
                Gap(30),
                CustomFormP(
                  desk: 'Password',
                  icon: Icons.vpn_key_outlined,
                  controller: _passwordController,
                ),
                Gap(30),
                buton(onPressed: () => loginUser(context), text: 'Sign In'),
                Gap(30),
                textbuton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    text: 'Sign Up',
                    requiredColor: primary),
                Gap(30),
                butonS(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadProductPage()));
                    },
                    text: 'Google',
                    image: 'assets/icon/iconGoogle.png')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// lib/pages/login.dart
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:tester/page/home.dart';

// class Login extends StatelessWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> loginUser(BuildContext context) async {
//     final url = Uri.parse('http://10.0.2.2:3000/login');
//     final username = _usernameController.text;
//     final password = _passwordController.text;

//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({'username': username, 'password': password}),
//       );

//       if (response.statusCode == 201) {
//         final responseData = jsonDecode(response.body);
//         print(responseData);
//         Get.off(Home());
//       } else {
//         final responseData = jsonDecode(response.body);
//         print(responseData);
//         final errorMessage = responseData['message'] ?? 'Login failed';
//         Get.snackbar('Login Failed', errorMessage);
//       }
//     } catch (error) {
//       print('Failed to login: $error');
//       Get.snackbar('Error', 'Failed to login. Please try again later.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => loginUser(context),
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
