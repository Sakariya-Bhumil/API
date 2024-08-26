import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Imageapi extends StatefulWidget {
  const Imageapi({super.key});

  @override
  State<Imageapi> createState() => _ImageapiState();
}

class _ImageapiState extends State<Imageapi> {
  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;

  Future getimage() async {
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (PickedFile != null) {
      image = File(PickedFile.path);
      setState(() {});
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showspinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('post', uri);

    request.fields['title'] = "static title";

    var multiport = new http.MultipartFile('image', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showspinner = false;
      });

      print("Image uploading successfully done!!!!!!");
    } else {
      setState(() {
        showspinner = false;
      });
      print("image failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
          body: Column(
        children: [
          GestureDetector(
            onTap: () {
              getimage();
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: image == null
                  ? Center(
                      child: Text("Pick Image"),
                    )
                  : Container(
                      child: Center(
                        child: Image.file(File(image!.path).absolute),
                      ),
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              uploadImage();
            },
            child: Container(
              child: Text("Upload"),
              height: 50,
              color: Colors.green[200],
            ),
          )
        ],
      )),
    );
  }
}
