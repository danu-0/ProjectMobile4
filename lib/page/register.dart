import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../page/login.dart';
import '../theme/theme.dart';
import '../widget/buton.dart';
import '../widget/form.dart';
import '../widget/textbuton.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                CustomForm(desk: 'Username', icon: Icons.person_2_outlined),
                Gap(30),
                CustomForm(desk: 'Email', icon: Icons.email_outlined),
                Gap(30),
                CustomForm(desk: 'Password', icon: Icons.vpn_key_outlined),
                Gap(30),
                buton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    text: 'Register'),
                Gap(30),
                text2(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    text: 'Sign In',
                    requiredColor: primary),
                Gap(30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
