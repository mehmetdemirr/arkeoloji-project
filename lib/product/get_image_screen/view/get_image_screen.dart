import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/image_picker/service/pick_manager.dart';
import 'package:demo/core/lifecycle/lifecycle_use.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class GetImageScreen extends StatefulWidget {
  const GetImageScreen({super.key});
  @override
  State<GetImageScreen> createState() => _GetImageScreenState();
}

class _GetImageScreenState extends State<GetImageScreen>
    with WidgetsBindingObserver, LifeCycleUse {
  @override
  void onResume() {
    printf("geri geldi");
  }

  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Picker Image")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //galeriden fotoğraf seç
            ElevatedButton.icon(
              onPressed: () async {
                await Permission.photos.request();
                final XFile? image = await PickManager().fetchImageGallery();
                setState(() {
                  _image = image;
                });
              },
              icon: const Icon(Icons.library_add),
              label: const Text("galeriden fotoğraf seç"),
            ),
            // kamerdan fotoğraf çek
            ElevatedButton.icon(
              onPressed: () async {
                await Permission.camera.request();
                final XFile? image = await PickManager().fetchImageCamera();
                setState(() {
                  _image = image;
                });
              },
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text("Fotoğraf çek"),
            ),
            //Birinci fotoğraf yazdırma yolu
            _image != null
                ? SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(
                      File(_image!.path),
                    ))
                : const SizedBox(),
            //ikinci fotoğraf yazdırma yolu
            FutureBuilder(
              future: _image?.readAsBytes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.memory(snapshot.data),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
