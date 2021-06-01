import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:assesment/image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic _image;
  final picker = ImagePicker();
  Future getImage(String type) async {
    final image;
    if (type == "camera") {
      image = await picker.getImage(source: ImageSource.camera);
    } else if (type == "gallery") {
      image = await picker.getImage(source: ImageSource.gallery);
    } else {
      image = null;
    }
    setState(() {
      _image = image?.path;
    });

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ImageShow(path: _image)))
        .then((value) => setState(() {
              _image = null;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => getImage("camera"),
                child: Text("Choose from Camera")),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => getImage("gallery"),
                child: Text("Choose from Gallery")),
          ),
        ],
      )),
    );
  }
}
