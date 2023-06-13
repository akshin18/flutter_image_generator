import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sert/auth/auth.dart';
import 'package:uuid/uuid.dart';

import '../generator/image_gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController prompt = TextEditingController();
  var image;
  Future<void> SignOut() async {
    try {
      await Auth().SignOut();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              controller: prompt,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      image = null;
                                    });
                                    var r = await Generator()
                                        .generate_image(prompt.text.trim());
                                    setState(() {
                                      image = r;
                                    });
                                  },
                                  child: const Text("Generate")),
                            ),
                          )
                        ],
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "Write prompt",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    width: 256,
                    height: 256,
                    margin: const EdgeInsets.only(top: 30),
                    child: image == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Container(
                                      height: 1,
                                      width: 1,
                                      child: CircularProgressIndicator())),
                            ],
                          )
                        : Image.memory(image, width: 512, height: 512),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    await SignOut();
                  },
                  child: const Text("sign out")),
            ],
          ),
        ),
      ),
    );
  }
}
