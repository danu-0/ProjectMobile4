import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widget/buton.dart';
import '../widget/form.dart';
import 'package:gap/gap.dart';
import '../widget/textbuton.dart';
import '../page/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                CustomForm(desk: 'Email', icon: Icons.email),
                Gap(30),
                CustomForm(desk: 'Password', icon: Icons.key),
                Gap(30),
                buton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    text: 'Sign In'),
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
                    onPressed: () {},
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
