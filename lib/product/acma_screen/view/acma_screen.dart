import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/acma_screen/viewmodel/acma_viewmodel.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AcmaScreen extends StatefulWidget {
  const AcmaScreen({super.key, required this.kaziId});
  final int kaziId;
  @override
  State<AcmaScreen> createState() => _AcmaScreenState();
}

class _AcmaScreenState extends State<AcmaScreen> {
  late UserLoginModel? user;

  @override
  void initState() {
    super.initState();
    var box = Hive.box<UserLoginModel>("user");
    user = box.get("user");
    getAcmalar(widget.kaziId);
  }

  void getAcmalar(int id) async {
    await context.read<AcmaViewModel>().getAcmalar(id);
  }

  void deleteAcma(int id) async {
    await context.read<AcmaViewModel>().deleteAcma(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acma Listesi")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _customList(context.watch<AcmaViewModel>().acmalar),
          ),
        ],
      ),
      floatingActionButton: user?.rol == "admin"
          ? FloatingActionButton(
              onPressed: () {
                context.router.push(AcmaAddRoute(kaziId: widget.kaziId));
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }

  Widget _customList(List<Acmalar>? kaziList) {
    return kaziList != null
        ? ListView.builder(
            itemCount: kaziList.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.router
                      .push(AcmaBilgiRoute(acmaId: kaziList[index].id ?? -1));
                },
                child: Padding(
                  padding: PaddingItem.small.str(),
                  child: Card(
                    child: Padding(
                      padding: PaddingItem.small.str(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "id:${kaziList[index].id ?? "name null"}",
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Açma Adı:${kaziList[index].name ?? "açma null"}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Açma Bilgi Sayısı:${kaziList[index].acmaBilgileri?.length ?? "açma bilgi null"}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          user?.rol == "admin"
                              ? ElevatedButton(
                                  onPressed: () {
                                    deleteAcma(kaziList[index].id ?? -1);
                                  },
                                  child: Text(
                                    "Sil",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageItem.arkeoloji.str(),
                  fit: BoxFit.cover,
                  width: context.width / 1.3,
                  height: context.height / 2,
                ),
                const Text("Açma bulunamadı !"),
              ],
            ),
          );
  }
}
