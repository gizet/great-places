import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600, maxHeight: 800);

    setState(() {
      if (imageFile == null) {
        return; // to prevent throwing error. can add a message if you want.
      }
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/${fileName}');
    widget.onSelectImage(savedImage); // is a pointer on the function
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No image taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
              onPressed: _takePicture, //when pressed is triggered.
              label: const Text('Take picture'),
              icon: const Icon(Icons.camera),
              textColor: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
