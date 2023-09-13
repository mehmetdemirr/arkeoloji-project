import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:demo/core/function/decoration_custom.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/image_picker/service/pick_manager.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/acma_bilgi_screen/service/acma_bilgi_service.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class AcmaBilgiAddScreen extends StatefulWidget {
  const AcmaBilgiAddScreen({super.key, required this.acmaId});
  final int acmaId;
  @override
  State<AcmaBilgiAddScreen> createState() => _AcmaBilgiAddScreenState();
}

class _AcmaBilgiAddScreenState extends State<AcmaBilgiAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _decription = TextEditingController();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acma Bilgi Ekle")),
      body: Column(
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
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
          //ikinci fotoğraf yazdırma yolu
          // FutureBuilder(
          //   future: _image?.readAsBytes(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     if (snapshot.data != null) {
          //       return SizedBox(
          //         height: 200,
          //         width: 200,
          //         child: Image.memory(snapshot.data),
          //       );
          //     }
          //     return const SizedBox();
          //   },
          // ),
          Padding(
            padding: PaddingItem.medium.str(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: PaddingItem.verticalMedium.str(),
                    child: TextFormField(
                      controller: _name,
                      decoration:
                          customInputDecoration("ad girin", "ad", context),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: PaddingItem.verticalMedium.str(),
                    child: TextFormField(
                      controller: _decription,
                      decoration: customInputDecoration(
                        "açıklama girin",
                        "açıklama",
                        context,
                      ),
                      minLines: 3,
                      maxLines: 5,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bu alan boş bırakılamaz.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool result =
                    await AcmaBilgiService(DioManager.dio).acmaBilgiAdd(
                  widget.acmaId,
                  _name.text,
                  _decription.text,
                  File(_image!.path),
                );
                if (result) {
                  //TODO: auto router ile yap

                  // ignore: use_build_context_synchronously
                  context.replaceRoute(AcmaBilgiRoute(acmaId: widget.acmaId));
                } else {
                  // ignore: use_build_context_synchronously
                  showSnackbar(context, "Açma oluşturlamadı !");
                }
              }
            },
            child: const Text("Ekle"),
          )
        ],
      ),
    );
  }
}
