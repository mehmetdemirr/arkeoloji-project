import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demo/core/navigation/app_router.dart';
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
      appBar: AppBar(title: const Text("Acmalar")),
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

  ListView _customList(List<Acmalar>? kaziList) {
    return ListView.builder(
      itemCount: kaziList?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.router
                .push(AcmaBilgiRoute(acmaId: kaziList?[index].id ?? -1));
          },
          child: Card(
            color: Colors.grey.shade200,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("id:${kaziList?[index].id ?? "name null"}"),
                    Text("name:${kaziList?[index].name ?? "city null"}"),
                    Text(
                        "acma bilgi sayısı:${kaziList?[index].acmaBilgileri?.length ?? "town null"}"),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    deleteAcma(kaziList?[index].id ?? -1);
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
