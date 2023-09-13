import 'package:auto_route/auto_route.dart';
import 'package:demo/core/extension/screen_size.dart';
import 'package:demo/core/function/show_snackbar.dart';
import 'package:demo/core/utilty/padding_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/kazi_user_add_sceen/service/kazi_user_add_service.dart';
import 'package:demo/product/kazi_user_add_sceen/viewmodel/kazi_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class KaziUserAddScreen extends StatefulWidget {
  const KaziUserAddScreen({super.key, required this.kaziId});
  final int kaziId;
  @override
  State<KaziUserAddScreen> createState() => _KaziUserAddScreenState();
}

class _KaziUserAddScreenState extends State<KaziUserAddScreen> {
  @override
  void initState() {
    super.initState();
    getUserList();
  }

  void getUserList() {
    context.read<KaziUserViewModel>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kazıya Kullanıcı Ekle"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.height / 10,
            child: _kaziCurrentUsers(),
          ),
          _usersListView(context.watch<KaziUserViewModel>().users),
        ],
      ),
    );
  }

  ListView _kaziCurrentUsers() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: PaddingItem.small.str() / 2,
          child: Container(
            height: context.height / 10,
            width: context.width / 4,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: Column(
              children: [
                const Text("kullanıcı ad"),
                const Text("ad soyad"),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel_outlined),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _usersListView(List<UserModel>? userList) {
    return Expanded(
      child: ListView.builder(
        itemCount: userList?.length ?? 0,
        itemBuilder: ((context, index) {
          return Padding(
            padding: PaddingItem.small.str() / 3,
            child: Card(
              child: Padding(
                padding: PaddingItem.small.str(),
                child: Row(
                  children: [
                    Text(
                      "Username : ${userList?[index].username ?? 'kullanıcı yok'}",
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        if (userList?[index].id != null) {
                          bool value =
                              await UserService(DioManager.dio).kaziUserAdd(
                            widget.kaziId,
                            userList?[index].id ?? -1,
                          );
                          if (value) {
                            // ignore: use_build_context_synchronously
                            showSnackbar(context,
                                "${userList?[index].username} eklendi");
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          showSnackbar(context,
                              "${userList?[index].username} eklenmedi !!!");
                        }
                      },
                      child: const Text("ekle"),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
