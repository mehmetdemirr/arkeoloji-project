import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/icon_items.dart';
import 'package:demo/core/utilty/images_items.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:demo/product/kazi_screen/viewmodel/kazi_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

@RoutePage()
class KaziScreen extends StatefulWidget {
  const KaziScreen({super.key});
  @override
  State<KaziScreen> createState() => _KaziScreenState();
}

class _KaziScreenState extends State<KaziScreen> {
  late UserLoginModel? user;
  @override
  void initState() {
    super.initState();
    var box = Hive.box<UserLoginModel>("user");
    user = box.get("user");
    Future.microtask(() {
      getKazilar();
    });
  }

  void getKazilar() async {
    await context.read<KaziViewModel>().getKazilar();
  }

  void deleteKazi(int id) async {
    await context.read<KaziViewModel>().deleteKazi(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoşgeldin ${user?.name ?? "kullanıcı"}"),
        actions: [
          IconButton(
            onPressed: () {
              context.router.pushNamed(RouterItem.setting.str());
            },
            icon: IconItem.setting.str(),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.watch<KaziViewModel>().isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
                  child: _customList(
                    context.watch<KaziViewModel>().kazilar,
                  ),
                ),
        ],
      ),
      floatingActionButton: user?.rol == "admin"
          ? FloatingActionButton(
              onPressed: () {
                context.router.pushNamed(RouterItem.kaziAdd.str());
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }

  Widget _customList(List<KaziModel>? kaziList) {
    // ignore: prefer_is_empty
    return kaziList != null
        ? ListView.builder(
            itemCount: kaziList.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.router
                      .push(AcmaRoute(kaziId: kaziList[index].id ?? -1));
                },
                child: Padding(
                  padding: PaddingItem.small.str(),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: PaddingItem.small.str(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Kazı Adı :${kaziList[index].name ?? "name null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "İl:${kaziList[index].city ?? "city null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "ilçe:${kaziList[index].town ?? "town null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Açma Sayısı:${kaziList[index].acmalar?.length ?? "acma sayısı null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Padding(
                                  padding: PaddingItem.small.str() / 4,
                                  child: Text(
                                    "Kişi Sayıs:${kaziList[index].users?.length ?? "kişi sayısı null"}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        user?.rol == "admin"
                            ? Padding(
                                padding: PaddingItem.medium.str(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: context.width / 4.5,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.navigateTo(
                                            KaziUserAddRoute(
                                                kaziId:
                                                    kaziList[index].id ?? -1),
                                          );
                                        },
                                        child: Text(
                                          "Kişi Ekle",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width / 4.5,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          deleteKazi(kaziList[index].id ?? -1);
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
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
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
                const Text("Kazı bulunamadı !"),
              ],
            ),
          );
  }
}
