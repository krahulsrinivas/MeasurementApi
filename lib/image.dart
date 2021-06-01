import 'dart:io';
import 'package:assesment/loader.dart';
import 'package:assesment/measurements.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class ImageShow extends StatefulWidget {
  final dynamic path;
  ImageShow({this.path});
  @override
  _ImageState createState() => _ImageState(path);
}

class _ImageState extends State<ImageShow> {
  final dynamic path;
  _ImageState(this.path);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: (path != null)
                    ? Image.file(
                        File(path),
                        width: 250,
                      )
                    : (Text("No Image selected, Choose another image"))),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      child: Text("Choose another image")),
                ),
                (path != null)
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: api,
                            child: Text("Proceed with this image")),
                      )
                    : (Container())
              ],
            ),
          )
        ],
      ),
    );
  }

  void api() async {
    String fileName = path.split('/').last;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Loader()));
    dynamic url = await firebase_storage.FirebaseStorage.instance
        .ref(fileName)
        .putFile(File(path))
        .then((snapshot) async {
      return await snapshot.ref.getDownloadURL().then((downloadUrl) {
        return downloadUrl;
      });
    });
    http.post(
        Uri.parse(
            "https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement"),
        body: {
          "imageURL": url
        }).then((res) => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Measurements({"info": res.body})))
        });
  }
}
