import 'package:flutter/material.dart';
import 'package:shoe_box_client/const/colors.dart';
import 'package:shoe_box_client/screen/init_screen.dart';
import 'package:shoe_box_client/screen/signup_screen.dart';
import '../api/login_api.dart';

final apiService = APIService();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    // Call the login API
    final (success, userId) = await apiService.loginPost(email, password);

    if (success == true) {
      // Navigate to the next screen after successful login
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return InitScreen(userId: userId);
      }));
    } else {
      // Show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('로그인 실패'),
            content: const Text('ID 또는 패스워드가 정확하지 않습니다.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle logoTs = const TextStyle(
      fontFamily: 'Kanit',
      fontSize: 56,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    );

    TextStyle signupTs = TextStyle(
      color: Colors.grey[600],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'shoe',
                        style: logoTs,
                      ),
                      Text(
                        'B',
                        style: logoTs,
                      ),
                      Text(
                        'O',
                        style: logoTs.copyWith(color: selectedColor),
                      ),
                      Text(
                        'X',
                        style: logoTs,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: selectedColor)),
                        hintText: 'ID',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: selectedColor)),
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => login(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '슈박스 이용이 처음이시라면',
                        style: signupTs,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SignupScreen();
                          }));
                        },
                        child: Text(
                          '회원가입',
                          style: signupTs.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
