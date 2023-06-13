import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class Generator {
  como() async {
    var uuid = Uuid();
    var res = uuid.v1();
    var add_res = res + "CKHovx6O54";
    var key = utf8.encode(add_res);
    var auth = sha256.convert(key);
    return [res, auth];
  }

  get_image_id(String promt) async {
    var d = await como();

    final uri = Uri.parse(
        "https://aiweb.picsart.com/v2/text-to-image-middleware/v2/task/");
    Map<String, String>? headers = {
      'authorization': 'Bearer ${d[1]}',
      'sid': d[0] ?? "",
      "Content-Type": "application/json"
    };
    Map<String, dynamic> payload = {
      "caption": promt,
      "styles": [],
      "batch_size": 2,
      "task_type": "t2i",
      "negative_prompt": ""
    };
    String jsonBody = json.encode(payload);
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      uri,
      headers: headers as Map<String, String>?,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if (statusCode == 200) {
      print(responseBody);
      d = json.decode(responseBody);
      return d["id"];
    } else {
      print("Pipec");
    }
    // return response.json()["id"],session
  }

  get_image_id_new(String promt) async {
    var d = await como();

    final uri = Uri.parse("https://playgroundai.com/api/models");
    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Cookie":
          "__Secure-next-auth.session-token=0290e5f6-d5d0-4d93-b24d-d47c6a89bc0d;"
    };
    Map<String, dynamic> payload = {
      "width": 512,
      "height": 512,
      "seed": Random().nextInt(999999999),
      "num_images": 1,
      "sampler": 1,
      "cfg_scale": 7,
      "guidance_scale": 7,
      "strength": 1.3,
      "steps": 25,
      "prompt": promt,
      "hide": false,
      "isPrivate": false,
      "modelType": "stable-diffusion",
      "batchId": "lbNUI1bXFg",
      "generateVariants": false,
      "initImageFromPlayground": false
    };
    String jsonBody = json.encode(payload);
    final encoding = Encoding.getByName('utf-8');
    Response response = await post(
      uri,
      headers: headers as Map<String, String>?,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if (statusCode == 200) {
      d = json.decode(responseBody);
      return d["images"][0]["url"];
    }
  }

  get_res(String image_id) async {
    var d = await como();
    final uri = Uri.parse(
        "https://aiweb.picsart.com/v2/text-to-image-middleware/v2/task/${image_id}");
    Map<String, String>? headers = {
      'authorization': 'Bearer ${d[1]}',
      'sid': d[0] ?? "",
      'aitouchpoint': 'ai_text_to_image',
      'userid': '',
      'username': '',
    };
    Response response = await get(
      uri,
      headers: headers as Map<String, String>?,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    if (statusCode == 200) {
      d = json.decode(responseBody);
      if (d["status"] == "ACCEPTED") {
        return [false, null];
      } else {
        return [true, d["data"]];
      }
    }
  }

  generate_image(String promt) async {
    var image_base = await get_image_id_new(promt);
    var bytesImage = Base64Decoder().convert(image_base.split(',')[1]);
    return bytesImage;
  }
}
