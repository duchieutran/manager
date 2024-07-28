import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/provider/edit_provider.dart';
import 'package:appdemo/provider/home_provider.dart';
import 'package:appdemo/screens/add_info/widgets/add_info_textfield.dart';
import 'package:appdemo/screens/home/widgets/home_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final init = Provider.of<HomeProvider>(context, listen: false);
      init.getData();
      init.setLoading(true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: context.watch<HomeProvider>().searchController,
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
                Provider.of<HomeProvider>(context, listen: false)
                    .searchShowInfo(
                        Provider.of<HomeProvider>(context, listen: false).key,
                        value);
              },
            ),
          ),
          Expanded(
              child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) => homeProvider.getLoading()
                ? const Center(child: CircularProgressIndicator())
                : !homeProvider.checkData
                    ? const ShowCustomDialog(
                        title: 'Lỗi',
                        content: 'Đại vương ơi, lỗi kết nối sever !')
                    : homeProvider.users.isEmpty
                        ? const ShowCustomDialog(
                            title: 'Lỗi',
                            content:
                                'Ôi đại vương, không có dữ liệu để hiển thị rồi !')
                        : ListView.builder(
                            itemCount: homeProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = homeProvider.users[index];
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
                                            context: context, userRemote: user);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Xoá',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () => Navigator.of(context).pushNamed(
                                    AppRouter.showinfo,
                                    arguments: user,
                                  ),
                                  leading: ClipOval(
                                    child: Image(
                                      image: NetworkImage(user.image),
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  title: Text(user.name),
                                  subtitle: Text(user.email),
                                ),
                              );
                            },
                          ),
          )),
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
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final provider = Provider.of<HomeProvider>(context);
            return Material(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 5, color: Colors.black),
                ),
                child: ListView.builder(
                  itemCount: provider.fillerTitle.length,
                  itemBuilder: (context, index) {
                    final title = provider.fillerTitle[index];
                    return RadioListTile(
                      value: title.toLowerCase(),
                      title: Text(title),
                      groupValue: provider.key,
                      onChanged: (value) {
                        provider.setKey(value!);
                        provider.searchShowInfo(
                            provider.key, provider.searchController.text);
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
            action: () {
              Provider.of<HomeProvider>(context, listen: false).getData();
              Navigator.of(context).pop();
            });
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
                final homeProvider =
                    Provider.of<HomeProvider>(context, listen: false);
                await homeProvider.deletaData(user: userRemote);
                // bool _deleteSuccess = await _deletaData(id: userRemote.id);
                if (homeProvider.checkData) {
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
      {required String title, required String content, VoidCallback? action}) {
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
