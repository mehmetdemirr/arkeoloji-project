import 'package:auto_route/auto_route.dart';
import 'package:demo/core/navigation/app_router.dart';
import 'package:demo/core/utilty/icon_items.dart';
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
    getKazilar();
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
          Expanded(
            child: _customList(context.watch<KaziViewModel>().kazilar),
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

  ListView _customList(List<KaziModel>? kaziList) {
    return ListView.builder(
      itemCount: kaziList?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.router.push(AcmaRoute(kaziId: kaziList?[index].id ?? -1));
          },
          child: Card(
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("name:${kaziList?[index].name ?? "name null"}"),
                    Text("city:${kaziList?[index].city ?? "city null"}"),
                    Text("town:${kaziList?[index].town ?? "town null"}"),
                    Text(
                        "acma sayıs:${kaziList?[index].acmalar?.length ?? "acma sayısı null"}"),
                    Text(
                        "kişi sayıs:${kaziList?[index].users?.length ?? "kişi sayısı null"}"),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.navigateTo(
                          KaziUserAddRoute(kaziId: kaziList?[index].id ?? -1),
                        );
                      },
                      child: const Text("kişi ekle"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteKazi(kaziList?[index].id ?? -1);
                      },
                      child: const Text("sil"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
