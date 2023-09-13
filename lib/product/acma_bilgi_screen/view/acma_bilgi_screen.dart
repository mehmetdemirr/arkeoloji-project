import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
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
      appBar: AppBar(title: const Text("Acma Bilgi Listesi")),
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

  Widget _customList(List<AcmaBilgileri>? acmaBilgiList) {
    return acmaBilgiList != null
        ? ListView.builder(
            itemCount: acmaBilgiList.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.navigateTo(
                      AcmaBilgiDetayRoute(acmaBilgi: acmaBilgiList[index]));
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "id:${acmaBilgiList[index].id ?? "name null"}",
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Ad : ${acmaBilgiList[index].name ?? "ad null"}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Açma Bilgi Açıklama : ${acmaBilgiList[index].description ?? "açıklama null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Sahibi :${acmaBilgiList[index].owner?.name ?? "sahibi null"}",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Image.network(
                                  acmaBilgiList[index].photo ?? "",
                                  width: context.width / 3,
                                ),
                              ],
                            ),
                          ),
                          //const Spacer(),
                          user?.rol == "admin"
                              ? ElevatedButton(
                                  onPressed: () {
                                    deleteAcmaBilgi(
                                        acmaBilgiList[index].id ?? -1);
                                  },
                                  child: Text(
                                    "sil",
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
                const Text("Açma bilgisi bulunamadı !"),
              ],
            ),
          );
  }
}
