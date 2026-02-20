import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_task_app/routes/app_route.gr.dart';
import 'package:meal_task_app/src/shared/gen/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  void dispose() {
    usernameCtrl.dispose();
    passCtrl.dispose();

    super.dispose();
  }

  Future<void> googleLogin() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final String email = googleUser.email;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> storedEmails = prefs.getStringList('users') ?? [];
      if (storedEmails.contains(email)) {
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUser', email);
        context.replaceRoute(const HomeRoute());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User already exists')));
      } else {
        storedEmails.add(email);
        await prefs.setStringList('users', storedEmails);

        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUser', email);
        context.replaceRoute(const HomeRoute());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('New user logged in')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login page',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Gap(35),
            TextFormField(
              controller: usernameCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Username'),
            ),
            Gap(10),
            TextFormField(
              controller: passCtrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
            ),
            Gap(15),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  if (usernameCtrl.text.trim() == 'admin' &&
                      passCtrl.text.trim() == '1234') {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    context.replaceRoute(HomeRoute());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid credentials')));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
            Gap(25),
            GestureDetector(
                onTap: () async {
                  await googleLogin();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Assets.svg.google.svg()),
                    )))
          ],
        ),
      ),
    );
  }
}
