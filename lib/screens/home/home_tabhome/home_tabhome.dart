import 'dart:async';
import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/global/img_path.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/provider/connect_provider.dart';
import 'package:appdemo/provider/edit_provider.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/screens/home/widgets/home_dialog.dart';
import 'package:appdemo/stores/home_stores.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final HomeStores homeStores = HomeStores();
  TextEditingController searchController = TextEditingController();
  String key = 'id';
  List<String> fillerTitle = ['ID', 'Name', 'Address', 'Age', 'Email'];

  @override
  void initState() {
    // homeStores.callGetData();
    homeStores.setIsLoading(true);
    homeStores.callGetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(
      builder: (context, networdStatus, child) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterDialog(context);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (value) {
                    homeStores.callGetData(key: key, value: value); // TODO :
                  },
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => homeStores.getIsloading()
                      ? const Center(child: CircularProgressIndicator())
                      : homeStores.users.isEmpty
                          ? const ShowCustomDialog(
                              title: 'Ôi Đại Vương',
                              content: 'Đại vương ơi, Không có dữ liệu !')
                          : Observer(
                              builder: (_) => ListView.builder(
                                itemCount: homeStores.users.length,
                                itemBuilder: (context, index) {
                                  final user = homeStores.users[index];
                                  return Slidable(
                                    startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: (context) {
                                            Navigator.of(context).pushNamed(
                                                AppRouter.showinfo,
                                                arguments: user);
                                          },
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                          icon: Icons.info,
                                          label: 'Thông tin',
                                        )
                                      ],
                                    ),
                                    endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            _showEditDialog(context, user);
                                          },
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Chỉnh sửa',
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            _showCancelDialog(
                                                context: context,
                                                userRemote: user);
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Xoá',
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      onTap: () =>
                                          Navigator.of(context).pushNamed(
                                        AppRouter.showinfo,
                                        arguments: user,
                                      ),
                                      leading: ClipOval(
                                          child: networdStatus !=
                                                  NetworkStatus.offline
                                              ? Image.network(
                                                  user.image,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  ImgPath().logoGit,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                )),
                                      title: Text(user.name),
                                      subtitle: Text(user.email),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.addinfo);
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SizedBox(
              height: 300,
              child: Material(
                child: ListView.builder(
                  itemCount: homeStores.users.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final title = fillerTitle[index];
                    return RadioListTile(
                      value: title.toLowerCase(),
                      title: Text(title),
                      groupValue: homeStores.getKey(),
                      onChanged: (value) {
                        homeStores.setKey(key = value as String);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, ModelUser user) {
    final provider = Provider.of<EditProvider>(context, listen: false);
    provider.defaultValueTextField(user);
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Center(child: Text('Edit profile')),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EditTextfield(
                    controller: provider.nameController,
                    title: 'Name',
                    hintText: 'Type your name',
                    icon: const Icon(Icons.person),
                    textInputType: TextInputType.name,
                  ),
                  EditTextfield(
                    controller: provider.ageController,
                    title: 'Age',
                    hintText: 'Type your age',
                    icon: const Icon(Icons.cake),
                    textInputType: TextInputType.number,
                  ),
                  EditTextfield(
                    controller: provider.addressController,
                    title: 'Address',
                    hintText: 'Type your address',
                    icon: const Icon(Icons.location_city),
                    textInputType: TextInputType.name,
                  ),
                  EditTextfield(
                    controller: provider.emailController,
                    title: 'Email',
                    hintText: 'Type your email',
                    icon: const Icon(Icons.email),
                    textInputType: TextInputType.emailAddress,
                  ),
                  EditTextfield(
                    controller: provider.imageController,
                    title: 'Image',
                    hintText: 'Type your image',
                    icon: const Icon(Icons.image),
                    textInputType: TextInputType.url,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 101, 179, 243),
                    ),
                    onPressed: () {
                      _checkValidate(provider: provider, user: user);
                    },
                    child: const Text(
                      'Thay Đổi',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkValidate(
      {required EditProvider provider, required ModelUser user}) async {
    if (!provider.checkEmpty()) {
      _showDialog(title: "Ôi Đại Vương", content: "Không được để trống đâu ạ.");
    } else {
      if (!await provider.loadImg()) {
        if (mounted) {
          _showDialog(
              title: "Ôi Đại Vương", content: "URL này không phải ảnh rồi.");
        }
      } else {
        await provider.updateData(user.id);
        _showDialog(
            title: "Đại Vương",
            content: "Sửa thành công rồi đại vương !",
            action: [
              CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () {
                    homeStores.callGetData();
                    Navigator.of(context).pop();
                  })
            ]);
      }
    }
  }

  void _showCancelDialog(
      {required BuildContext context, required ModelUser userRemote}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Đại vương chú ý"),
          content:
              Text("Ngài chắc chắn muốn chém đầu ${userRemote.name} chứ ?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Trẫm Tha'),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await homeStores.callRemoveData(user: userRemote);
                if (homeStores.getIsRemove()) {
                  _showDialog(
                      title: 'Tin Mừng', content: 'Chém đầu thành công .');
                } else {
                  _showDialog(
                      title: 'Toang Rồi',
                      content: 'Chém đầu thật bại rồi đại vương ơi.');
                }
              },
              child: const Text("Chém"),
            ),
          ],
        );
      },
    );
  }

  void _showDialog(
      {required String title, required String content, List<Widget>? action}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowCustomDialog(
          title: title,
          content: content,
          action: action,
        );
      },
    );
  }
}
