import 'package:flutter/material.dart';
import 'package:sert/auth/auth.dart';
import 'auth_widget.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({super.key});

  @override
  State<ResetPwd> createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  TextEditingController mail_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset")),
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
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        "Reset your Password",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InputWidget(
                        hintText: "mail",
                        isPwd: false,
                        textEditingController: mail_controller),
                  ),
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            var result = await Auth().RessetPassword(
                                email: mail_controller.text.trim());
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(result)));
                          },
                          child: Text("Send Mail")))
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
