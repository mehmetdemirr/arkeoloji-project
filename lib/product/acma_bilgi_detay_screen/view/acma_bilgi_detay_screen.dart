import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AcmaBilgiDetayScreen extends StatefulWidget {
  const AcmaBilgiDetayScreen({super.key, required this.acmaBilgi});
  final AcmaBilgileri acmaBilgi;
  @override
  State<AcmaBilgiDetayScreen> createState() => _AcmaBilgiDetayScreenState();
}

class _AcmaBilgiDetayScreenState extends State<AcmaBilgiDetayScreen> {
  late AcmaBilgileri _acmaBilgi;
  @override
  void initState() {
    super.initState();
    _acmaBilgi = widget.acmaBilgi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Açma Bilgi Detay")),
      body: Padding(
        padding: PaddingItem.medium.str(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              _acmaBilgi.photo ?? "",
              width: context.width / 1.5,
            ),
            Padding(
              padding: PaddingItem.small.str() / 4,
              child: Text(
                "Ad :${_acmaBilgi.name ?? "ad null"}",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: PaddingItem.small.str() / 4,
              child: Text(
                "Sahibi :${_acmaBilgi.owner?.name ?? "sahibi null"}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: PaddingItem.small.str() / 4,
              child: Text(
                "Açma Bilgi Açıklama : ${_acmaBilgi.description ?? "açıklama null"}",
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
