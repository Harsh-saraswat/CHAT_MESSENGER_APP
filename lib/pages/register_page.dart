import 'package:chat_messenger_app/components/my_button.dart';
import 'package:chat_messenger_app/components/my_text_field.dart';
import 'package:chat_messenger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void SignUp() async {
    if (passwordcontroller.text != passwordcontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Re-check confirm password")));

      return;
    }

    final authservice = Provider.of<AuthService>(context, listen: false);
    try {
      authservice.signUpWithEmailAndPassword(
          emailcontroller.text, passwordcontroller.text, namecontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const SizedBox(height: 50),

                  // welcome
                  Text(
                    "Let's Create an account for you",
                    style: GoogleFonts.bebasNeue(
                        textStyle: TextStyle(fontSize: 30)),
                  )

                  // email and password
                  ,
                  MyTextField(
                      controller: namecontroller,
                      hintText: "Name",
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: emailcontroller,
                      hintText: "Email",
                      obscureText: false),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: passwordcontroller,
                      hintText: "Password",
                      obscureText: true),
                  const SizedBox(height: 20),
                  MyTextField(
                      controller: confirmpasswordcontroller,
                      hintText: "Confirm Password",
                      obscureText: true),
                  const SizedBox(height: 50),
                  // sign in Button
                  MyButton(onTap: SignUp, text: "Sign Up"),
                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
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
