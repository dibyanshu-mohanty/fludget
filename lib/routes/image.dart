import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageImplementation extends StatefulWidget {
  const ImageImplementation({Key? key}) : super(key: key);

  @override
  State<ImageImplementation> createState() => _ImageImplementationState();
}

class _ImageImplementationState extends State<ImageImplementation> {
  bool isFileImageSelected = false;
  File? fileImageSelected;
  var memoryImage;

  @override
  void initState() {
    getMemoryImage();
    super.initState();
  }

  getMemoryImage() async {
    var result = await http.get(
      Uri.parse(
          "https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png"),
    );

    setState(() {
      memoryImage = result.bodyBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Image from assets:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("assets/images/meme.png"),
              SizedBox(height: 15.0),
              Text(
                "Image from internet:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image(
                image: NetworkImage(
                    "https://uploads-ssl.webflow.com/5ee12d8e99cde2e20255c16c/5ef24ca36ab1f5eda546e719_flutter-meme-guarantee-it.jpg"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Image from file",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  try {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png'],
                    );

                    if (result != null) {
                      setState(() {
                        fileImageSelected = File(result.paths.first!);
                        isFileImageSelected = true;
                      });
                    }
                  } catch (e) {
                    throw "Platform Exception";
                  }
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red.withOpacity(0.3),
                  ),
                  child: isFileImageSelected
                      ? Image.file(
                          fileImageSelected!,
                          fit: BoxFit.cover,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Click here to pick a image",
                              style: const TextStyle(
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.upload,
                              color: Colors.white,
                            )
                          ],
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Usually we prefer to use memory image when we are working with web
              Text(
                "Image from memory",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.3),
                ),
                child: memoryImage != null
                    ? Image.memory(
                        memoryImage,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageDescription extends StatelessWidget {
  const ImageDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Image Description Here',
      ),
    );
  }
}
