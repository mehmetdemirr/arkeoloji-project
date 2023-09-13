import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/product/acma_bilgi_screen/view_model/acma_bilgi_viewmodel.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AcmaBilgiScreen extends StatefulWidget {
  const AcmaBilgiScreen({super.key, required this.acmaId});
  final int acmaId;
  @override
  State<AcmaBilgiScreen> createState() => _AcmaBilgiScreenState();
}

class _AcmaBilgiScreenState extends State<AcmaBilgiScreen> {
  late UserLoginModel? user;

  @override
  void initState() {
    super.initState();
    var box = Hive.box<UserLoginModel>("user");
    user = box.get("user");
    getAcmaBilgiler(widget.acmaId);
  }

  void getAcmaBilgiler(int acmaId) async {
    await context.read<AcmaBilgiViewModel>().getAcmaBilgiler(acmaId);
  }

  void deleteAcmaBilgi(int acmaBilgiId) async {
    await context.read<AcmaBilgiViewModel>().deleteAcmaBilgi(acmaBilgiId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acma Bilgi listesi")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
                _customList(context.watch<AcmaBilgiViewModel>().acmaBilgiler),
          ),
        ],
      ),
      floatingActionButton: // user?.rol == "admin"
          FloatingActionButton(
        onPressed: () {
          context.router.push(AcmaBilgiAddRoute(acmaId: widget.acmaId));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _customList(List<AcmaBilgileri>? acmaBilgiList) {
    return ListView.builder(
      itemCount: acmaBilgiList?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // context.router
            //     .push(AcmaBilgiAddRoute(acmaId: kaziList?[index].id ?? -1));
          },
          child: Card(
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("id:${acmaBilgiList?[index].id ?? "name null"}"),
                    Text("name:${acmaBilgiList?[index].name ?? "city null"}"),
                    Text(
                        "acma bilgi açıklama:${acmaBilgiList?[index].description ?? "town null"}"),
                    Text(
                        "acma bilgi sahibi:${acmaBilgiList?[index].owner?.name ?? "town null"}"),
                    Image.network(
                      acmaBilgiList?[index].photo ?? "",
                      width: context.width / 1.5,
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    deleteAcmaBilgi(acmaBilgiList?[index].id ?? -1);
                  },
                  child: const Text("sil"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
