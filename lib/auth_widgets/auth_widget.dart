import 'package:flutter/material.dart';
import 'resset_pwd.dart';

class Some extends StatelessWidget {
  final TextEditingController mail_controler;
  final TextEditingController pwd_controler;
  const Some(
      {super.key, required this.mail_controler, required this.pwd_controler});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InputWidget(
        hintText: 'email',
        textEditingController: mail_controler,
        isPwd: false,
      ),
      const SizedBox(
        height: 10,
      ),
      InputWidget(
        hintText: 'password',
        textEditingController: pwd_controler,
        isPwd: true,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResetPwd()),
          );
        },
        child: const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            "Resset password",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          )
        ]),
      )
    ]);
  }
}

class InputWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPwd;

  const InputWidget(
      {required this.textEditingController,
      required this.hintText,
      required this.isPwd,
      Key? key})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool pwdVisibility = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: widget.isPwd == false ? false : !pwdVisibility,
      decoration: InputDecoration(
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        suffixIcon: widget.isPwd == true
            ? InkWell(
                onTap: () => setState(
                  () => pwdVisibility = !pwdVisibility,
                ),
                child: Icon(
                  pwdVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
              )
            : null,
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

class GoogleBtn extends StatelessWidget {
  final Function() onPressed;
  const GoogleBtn({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Google",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ));
  }
}
