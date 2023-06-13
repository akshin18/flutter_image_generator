import 'package:flutter/material.dart';
import '../auth/auth.dart';
import 'auth_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController mail_controller = TextEditingController();
  TextEditingController pwd_controller = TextEditingController();
  TextEditingController pwd_controller_rep = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                width: 300,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: InputWidget(
                          textEditingController: mail_controller,
                          hintText: "mail",
                          isPwd: false),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: InputWidget(
                          textEditingController: pwd_controller,
                          hintText: "pwd",
                          isPwd: true),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: InputWidget(
                          textEditingController: pwd_controller_rep,
                          hintText: "repeate pwd",
                          isPwd: true),
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (pwd_controller.text ==
                                pwd_controller_rep.text) {
                              await Auth().singUp(
                                  email: mail_controller.text.trim(),
                                  password: pwd_controller.text.trim());
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Successfully registered!")));
                            } else {
                              print("Wrong pwd");
                            }
                          },
                          child: Text("Sign up")),
                    )
                  ],
                ),
              ),
              Container(),
            ]),
      ),
    );
  }
}
